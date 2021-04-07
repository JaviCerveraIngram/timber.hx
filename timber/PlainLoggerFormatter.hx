/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;

class PlainLoggerFormatter implements LoggerFormatter {
    public function new() {
    }

    public function formatLine(level:Int, text:String):String {
        return '${getPrefix(level)}  $text';
    }

    private function getPrefix(level:Int):String {
        return '${formatDate()}  ${formatLevel(level)}';
    }

    private static function formatDate():String {
        final date = Date.now();
        final year = StringTools.lpad(Std.string(date.getUTCFullYear()), '0', 4);
        final month = StringTools.lpad(Std.string(date.getUTCMonth() + 1), '0', 2);
        final day = StringTools.lpad(Std.string(date.getUTCDate()), '0', 2);
        final hour = StringTools.lpad(Std.string(date.getUTCHours()), '0', 2);
        final minute = StringTools.lpad(Std.string(date.getUTCMinutes()), '0', 2);
        final second = StringTools.lpad(Std.string(date.getUTCSeconds()), '0', 2);
        return '$year-$month-${day} $hour:$minute:$second';
    }

    private static function formatLevel(level:Int):String {
        final levelNames = [
            "ERROR",
            "WARNING",
            "INFO",
            "DEBUG"
        ];
        return (level >= 0 && level < levelNames.length)
            ? levelNames[level]
            : 'LEVEL:$level';
    }

    public function getFileExtension():String {
        return 'log';
    }

    public function copy():PlainLoggerFormatter{
        return new PlainLoggerFormatter();
    }
}
