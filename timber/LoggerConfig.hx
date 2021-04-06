/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;

import haxe.ds.StringMap;


/**
    Creation time configuration for a `Logger`.
**/
class LoggerConfig {
    private static final PATH = "path";
    private static final FILENAME = "filename";
    private static final LEVEL = "level";
    private static final HANDLERS = "handlers";
    private static final levelTranslation:StringMap<Int> = [
        "ERROR" => Logger.LEVEL_ERROR,
        "WARNING" => Logger.LEVEL_WARNING,
        "INFO" => Logger.LEVEL_INFO,
        "DEBUG" => Logger.LEVEL_DEBUG
    ];
    
    private final properties = new StringMap<Dynamic>();

    public function new() {
        final defaultFilename = "default";
        final formatter = new PlainLoggerFormatter();
        final writer = new FileLoggerWriter('$defaultFilename.${formatter.getFileExtension()}');
        this
            .withPath("logs")
            .withFilename(defaultFilename)
            .withLevel(Logger.LEVEL_INFO)
            .withHandlers([new LoggerHandler(formatter, writer)]);
    }

    /**
        @return Whether this config has the indicated property.
    **/
    public function hasProperty(name:String):Dynamic {
        return properties.exists(name);
    }

    /**
        @return The value for the given property, or `null` if it doesn't exit.
    **/
    public function getProperty(name:String):Dynamic {
        return properties.get(name);
    }

    /**
        @return The path where the log file will be created. This is only the directory name,
        filename must be retrieved with `getFilename`.
    **/
    public function getPath():String {
        return getProperty(PATH);
    }

    /**
        @return The filename of the log. This must not include file extension, since this
        will be indicated to each `LoggerWriter` by its associated `LoggerFormatter`.
    **/
    public function getFilename():String {
        return getProperty(FILENAME);
    }

    /**
        @return The default logging level. Only messages logged with this level or below will
        be output. These will be passed to each `LoggerWriter` who has not specified a different
        logging level when the `Logger` is created.
    **/
    public function getLevel():Int {
        return getProperty(LEVEL);
    }

    /**
        @return The array of `LoggerHandler` objects that will be passed to the `Logger`.
    **/
    public function getHandlers():Array<LoggerHandler> {
        return getProperty(HANDLERS);
    }

    /**
        Sets the value of a property.
        @return `this` instance to support a fluent interface.
    **/
    public function withProperty(name:String, value:Dynamic):LoggerConfig {
        properties.set(name, value);
        return this;
    }

    /**
        Sets the path where the log file will be created. This is only the directory name,
        filename must be specified with `withFilename`.
        @return `this` instance to support a fluent interface.
    **/
    public function withPath(path:String):LoggerConfig {
        return withProperty(PATH, path);
    }

    /**
        Sets the filename of the log. This must not include file extension, since this
        will be indicated to each `LoggerWriter` by its associated `LoggerFormatter`.
        @return `this` instance to support a fluent interface.
    **/
    public function withFilename(filename:String):LoggerConfig {
        return withProperty(FILENAME, filename);
    }

    /**
        Sets the level of the log. Only messages logged with this level or below will
        be output. These will be passed to each `LoggerWriter` who has not specified a different
        logging level when the `Logger` is created.
        @return `this` instance to support a fluent interface.
    **/
    public function withLevel(level:Int):LoggerConfig {
        return withProperty(LEVEL, level);
    }

    /**
        Sets the level of the log by providing the level name. Only messages logged with this level
        or below will be output. These will be passed to each `LoggerWriter` who has not specified
        a different logging level when the `Logger` is created. If `name` is invalid, the function
        has no effect.
        @return `this` instance to support a fluent interface.
    **/
    public function withLevelName(name:String):LoggerConfig {
        if (levelTranslation.exists(name)) {
            return withLevel(levelTranslation.get(name));
        }
        return this;
    }

    /**
        Sets the array of handlers that will be added to the `Logger`.
        @return `this` instance to support a fluent interface.
    **/
    public function withHandlers(handlers:Array<LoggerHandler>) {
        return withProperty(HANDLERS, handlers);
    }
}
