package;

import massive.munit.Assert;
import timber.FileLoggerWriter;
import timber.Logger;
import timber.LoggerConfig;
import timber.PlainLoggerFormatter;

class LoggerConfigTest {
	@Test
	public function testConstructor() {
        final config = new LoggerConfig();
		Assert.areEqual("logs", config.getPath());
        Assert.areEqual("default", config.getFilename());
        Assert.areEqual(Logger.LEVEL_INFO, config.getLevel());
        Assert.areEqual(1, config.getHandlers().length);
        Assert.isTrue(Std.isOfType(config.getHandlers()[0].getFormatter(), PlainLoggerFormatter));
        Assert.isTrue(Std.isOfType(config.getHandlers()[0].getWriter(), FileLoggerWriter));
        Assert.areEqual("default.log", config.getHandlers()[0].getWriter().getFilename());
	}
}
