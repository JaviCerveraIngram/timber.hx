/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;

/**
    Represents a log formatter.The `Logger` uses an instance of a class that implements
    this interface (`PlainLoggerFormatter` by default) to write log messages.
*/
interface LoggerFormatter {
    public function formatLine(level:Int, text:String):String;
    public function getFileExtension():String;
    public function copy():LoggerFormatter;
}
