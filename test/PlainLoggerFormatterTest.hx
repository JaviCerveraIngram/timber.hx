package;

import massive.munit.Assert;
import timber.Logger;
import timber.PlainLoggerFormatter;

class PlainLoggerFormatterTest {
	@Test
	public function testFormatLine() {
        final formatter = new PlainLoggerFormatter();
        Assert.areEqual('  INFO  Hello', formatter.formatLine(Logger.LEVEL_INFO, "Hello").substr(19));
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
}
