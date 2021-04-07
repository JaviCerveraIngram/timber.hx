package;

import massive.munit.Assert;
import timber.Logger;
import timber.FileLoggerWriter;

class FileLoggerWriterTest {
	@Test
	public function testConstructor() {
        final writer = new FileLoggerWriter("filename.log");
        Assert.areEqual("filename.log", writer.getFilename());
	}
}
