#!/usr/bin/env qore
# -*- mode: qore; indent-tabs-mode: nil -*-
# Copyright (C) 2026 Qore Technologies, s.r.o.

# Run by completion-callback.qtest in a terminal that script(1) creates, with the result file and the kind of
# completion callback as arguments; the test types "ab", Tab and Enter once the prompt is displayed.
# - history: the callback calls history_add(), which takes the module lock that line() holds
# - replace: the callback replaces itself with set_callback() and then uses an object that it captured; the module
#   holds the only reference to the callback, so the object must be destroyed only after the callback returns

%new-style
%require-types
%strict-args
%enable-all-warnings

%requires linenoise

our list<string> events = ();

class Witness {
    private {
        string name;
    }

    constructor(string name) {
        self.name = name;
    }

    destructor() {
        events += "destroyed " + name;
    }

    string getName() {
        return name;
    }
}

string result_path = ARGV[0];
string kind = ARGV[1];

# the callback is created in a function, so the module holds the only reference to it
sub install(string kind) {
    Witness w(kind);
    switch (kind) {
        case "history":
            Linenoise::set_callback(list<string> sub (string input) {
                events += "start history";
                Linenoise::history_add("added in the callback");
                events += "after history_add " + w.getName();
                return ("abc",);
            });
            break;
        case "replace":
            Linenoise::set_callback(list<string> sub (string input) {
                events += "start replace";
                Linenoise::set_callback(list<string> sub (string input) { return (); });
                events += "after replace " + w.getName();
                return ("abc",);
            });
            break;
        default:
            throw "ARG-ERROR", sprintf("unknown kind %y", kind);
    }
}

install(kind);
*string line = Linenoise::line("callback> ");
list<string> result = ("line=" + line) + events;
File f();
f.open2(result_path, O_CREAT | O_WRONLY | O_TRUNC);
f.write(foldl $1 + "\n" + $2, result);
