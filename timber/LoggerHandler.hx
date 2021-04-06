/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;


/**
    This class representes a handler for the Logger. An handler is composed of a formatter
    (which will the define the final format of the message, like Markdown) and a writer
    (capable of writing the formatted message to an output, like a file).
**/
class LoggerHandler {
    private final formatter:LoggerFormatter;
    private final writer:LoggerWriter;

    public function new(formatter:LoggerFormatter, writer:LoggerWriter) {
        this.formatter = formatter;
        this.writer = writer;
    }

    public function getFormatter():LoggerFormatter {
        return formatter;
    }

    public function getWriter():LoggerWriter {
        return writer;
    }

    public function copy():LoggerHandler {
        return new LoggerHandler(formatter.copy(), writer.copy());
    }
}
