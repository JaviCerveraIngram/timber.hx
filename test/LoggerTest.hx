package;

import massive.munit.Assert;
import timber.FileLoggerWriter;
import timber.Logger;
import timber.LoggerConfig;
import timber.LoggerHandler;
import timber.LoggerWriter;
import timber.PlainLoggerFormatter;

class LoggerTest {
	@Test
	public function testConstructor() {
        final logger = new Logger();
        Assert.areEqual("logs", logger.getPath());
		Assert.areEqual(Logger.LEVEL_INFO, logger.getLevel());
		Assert.areEqual(1, logger.getHandlers().length);
		Assert.isTrue(Std.isOfType(logger.getHandlers()[0].getFormatter(), PlainLoggerFormatter));
		Assert.isTrue(Std.isOfType(logger.getHandlers()[0].getWriter(), FileLoggerWriter));
		Assert.areEqual("default", logger.getFilename());
	}

	@Test
	public function testConstructorWithConfig() {
		final config = new LoggerConfig()
			.withPath("newPath")
			.withFilename("newFilename")
			.withLevel(-1);
        final logger = new Logger(config);
        Assert.areEqual("newPath", logger.getPath());
		Assert.areEqual(Logger.LEVEL_ERROR, logger.getLevel());
		Assert.areEqual(1, logger.getHandlers().length);
		Assert.isTrue(Std.isOfType(logger.getHandlers()[0].getFormatter(), PlainLoggerFormatter));
		Assert.isTrue(Std.isOfType(logger.getHandlers()[0].getWriter(), FileLoggerWriter));
		Assert.areEqual("newFilename", logger.getFilename());
	}

	@Test
	public function testCopy() {
		final config = new LoggerConfig()
			.withPath("newPath")
			.withFilename("newFilename")
			.withLevel(-1);
        final logger = new Logger(config).copy();
        Assert.areEqual("newPath", logger.getPath());
		Assert.areEqual(Logger.LEVEL_ERROR, logger.getLevel());
		Assert.areEqual(1, logger.getHandlers().length);
		Assert.isTrue(Std.isOfType(logger.getHandlers()[0].getFormatter(), PlainLoggerFormatter));
		Assert.isTrue(Std.isOfType(logger.getHandlers()[0].getWriter(), FileLoggerWriter));
		Assert.areEqual("newFilename", logger.getFilename());
	}

	@Test
	public function testWrite() {
		final formatter = new PlainLoggerFormatter();
		final writer = new ArrayLoggerWriter();
		final config = new LoggerConfig()
			.withHandlers([new LoggerHandler(formatter, writer)]);
        final logger = new Logger(config);
		logger.write(Logger.LEVEL_INFO, "Info");
		logger.write(Logger.LEVEL_DEBUG, "Debug");
		logger.write(Logger.LEVEL_ERROR, "Error");
		Assert.areEqual(2, writer.getLines().length);
		Assert.areEqual(formatter.formatLine(Logger.LEVEL_INFO, "Info"), writer.getLines()[0]);
		Assert.areEqual(formatter.formatLine(Logger.LEVEL_ERROR, "Error"), writer.getLines()[1]);
	}
}

private class ArrayLoggerWriter implements LoggerWriter {
	private var level:Int = Logger.LEVEL_INFO;
	private var lines:Array<String> = new Array<String>();

	public function new() {
	}

    public function getFilename():String {
		return null;
	}

    public function setFilename(filename:String):Void {
	}

    public function setLoggerLevel(level:Int):Void {
		this.level = level;
	}

    public function writeLine(level:Int, line:String):Void {
		if (this.level >= level) {
			lines.push(line);
		}
	}

    public function copy():ArrayLoggerWriter {
		final logger = new ArrayLoggerWriter();
		logger.setLoggerLevel(this.level);
		logger.lines = this.lines.copy();
		return logger;
	}

	public function getLines():Array<String> {
		return lines.copy();
	}
}
