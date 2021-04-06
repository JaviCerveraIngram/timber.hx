/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;

/**
    This is the main class of the library.
**/
class Logger {
    public static final LEVEL_ERROR = 0;
    public static final LEVEL_WARNING = 1;
    public static final LEVEL_INFO = 2;
    public static final LEVEL_DEBUG = 3;

    private final path:String;
    private final level:Int;
    private final handlers:Array<LoggerHandler>;

    public function new(?config:LoggerConfig) {
        config = (config != null) ? config : new LoggerConfig();
        this.path = config.getPath();
        this.level = Std.int(Math.min(Math.max(config.getLevel(), LEVEL_ERROR), LEVEL_DEBUG));
        this.handlers = config.getHandlers().copy();
        this.setFilename(config.getFilename());
    }

    /** @returns The path where logs are stored. **/
    public function getPath():String {
        return this.path;
    }

    /**
        @return Int The level of the log. One of: `LEVEL_ERROR`, `LEVEL_WARNING`,
        `LEVEL_INFO`, `LEVEL_DEBUG`.
    **/
    public function getLevel():Int {
        return this.level;
    }

    /** @returns The defined handlers for this logger. Do not modify this array. **/
    public function getHandlers():Array<LoggerHandler> {
        return this.handlers;
    }

    /**
        Sets the filename of the log. All future log messages will get printed to this file.

        Filename extension must be omitted, since it is provided by the formatters
        used in each handler.
    **/
    public function setFilename(filename:String):Void {
        if (filename != null) {
            final fullname = (this.path != null)
                ? this.path + "/" + filename
                : filename;
            Lambda.iter(this.handlers, function(handler) {
                final formatter = handler.getFormatter();
                final writer = handler.getWriter();
                writer.setFilename('$fullname.${formatter.getFileExtension()}');
            });
        }
    }

    /** @returns The last filename that was set. **/
    public function getFilename():String {
        final firstHandler = (this.handlers.length > 0) ? this.handlers[0] : null;
        if (firstHandler != null) {
            final filename = firstHandler.getWriter().getFilename();
            final ext = firstHandler.getFormatter().getFileExtension();
            final noPathFilename = (filename != null && filename.indexOf(this.path) == 0)
                ? filename.substr(this.path.length + 1)
                : filename;
            final noExtFilename = (noPathFilename != null && ext != null && ext.length > 0)
                ? noPathFilename.substr(0, noPathFilename.length - ext.length - 1)
                : noPathFilename;
            return noExtFilename;
        } else {
            return null;
        }
    }

    /**
     * Writes a message to the log in the specified level.
     * @param level Message level. One of: `LEVEL_ERROR`, `LEVEL_WARNING`, `LEVEL_INFO`, `LEVEL_DEBUG`.
     * @param message Message to log.
     */
    public function write(level:Int, message:String):Void {
        if (this.level >= level) {
            for (handler in this.handlers) {
                final formatter = handler.getFormatter();
                final writer = handler.getWriter();
                writer.writeLine(level, formatter.formatLine(level, message));
            }
        }
    }

    public function copy():Logger {
        return new Logger(new LoggerConfig()
            .withPath(this.getPath())
            .withFilename(this.getFilename())
            .withLevel(this.getLevel())
            .withHandlers([for (handler in this.handlers) handler.copy()]));
    }
}
