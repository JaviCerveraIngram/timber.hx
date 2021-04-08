import massive.munit.TestSuite;

import LoggerTest;
import PlainLoggerFormatterTest;
import LoggerConfigTest;
import FileLoggerWriterTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */
class TestSuite extends massive.munit.TestSuite
{
    public function new()
    {
        super();

        add(LoggerTest);
        add(PlainLoggerFormatterTest);
        add(LoggerConfigTest);
        add(FileLoggerWriterTest);
    }
}
