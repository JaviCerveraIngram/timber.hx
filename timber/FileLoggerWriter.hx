/*
    This file is part of the Ingram Micro CloudBlue Connect SDK.
    Copyright (c) 2019 Ingram Micro. All Rights Reserved.
*/
package timber;

import haxe.io.Path;
import sys.FileSystem;

class FileLoggerWriter implements LoggerWriter {
    private var filename:String;
    private var file:Null<sys.io.FileOutput>;
    private var level:Null<Int>;

    public function new(filename:String, ?level:Int) {
        this.filename = filename;
        this.file = null;
        this.level = level;
    }

    public function getFilename():String {
        return this.filename;
    }

    public function setFilename(filename:String):Void {
        final currentFilename = this.filename;
        this.filename = filename;
        if (filename != currentFilename && this.file != null) {
            this.file.close();
            this.file = null;
        }
    }

    public function setLoggerLevel(level:Int):Void {
        if (this.level == null) {
            this.level = level;
        }
    }

    public function writeLine(level:Int, line:String):Void {
        if (this.getFile() != null) {
            this.getFile().writeString('$line\n');
            this.getFile().flush();
        }
        try {
            // This could fail if stdout has been overriden
            Sys.println(line);
        } catch (ex: Dynamic) {
        }
    }

    private function getFile():sys.io.FileOutput {
        if (this.file == null && this.filename != null) {
            final path = Path.directory(this.filename);
            if (path != '' && !FileSystem.exists(path)) {
                FileSystem.createDirectory(path);
            }
        #if !js
            this.file = sys.io.File.append(this.filename);
        #else
            final content: String = sys.FileSystem.exists(this.filename)
                    && !sys.FileSystem.isDirectory(this.filename)
                ? sys.io.File.getContent(this.filename)
                : null;
            this.file = sys.io.File.write(this.filename);
            if (content != null) {
                this.file.writeString(content);
            }
        #end
        }
        return this.file;
    }

    public function copy():FileLoggerWriter {
        return new FileLoggerWriter(getFilename(), this.level);
    }
}
