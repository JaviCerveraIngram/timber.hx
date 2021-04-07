package;

import massive.munit.Assert;
import timber.Logger;
import timber.PlainLoggerFormatter;

class PlainLoggerFormatterTest {
	@Test
	public function testFormatLine() {
        final formatter = new PlainLoggerFormatter();
        Assert.areEqual('${formatDate()}  INFO  Hello', formatter.formatLine(Logger.LEVEL_INFO, "Hello"));
	}

    @Test
	public function testGetFileExtension() {
        final formatter = new PlainLoggerFormatter();
        Assert.areEqual("log", formatter.getFileExtension());
	}

    @Test
	public function testCopy() {
        final formatter = new PlainLoggerFormatter();
        Assert.isTrue(Std.isOfType(formatter.copy(), PlainLoggerFormatter));
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
}
