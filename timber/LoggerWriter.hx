/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;

/**
    Represents the functionality of writing logs to some output. The `Logger` uses an
    instance of a class that implements this interface (`FileLoggerWriter` by default)
    to write log messages.
**/
interface LoggerWriter {
    /** @returns The last filename that was set. **/
    public function getFilename():String;

    /** Sets the filename of the log. **/
    public function setFilename(filename:String):Void;

    /**
        Indicates the level of the `Logger` `this` writer is attached to.
        This value could be ignored by `this` writer (for example, if `this` is
        created with a more restrictive level).
    **/
    public function setLoggerLevel(level:Int):Void;

    /** Writes a line to the log output. The new line character is added by the method. **/
    public function writeLine(level:Int, line:String):Void;

    /** @return A copy of `this` writer. **/
    public function copy():LoggerWriter;
}
