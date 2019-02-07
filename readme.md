# Arch Linux Tutorials
These are instructions mainly made for myself to not search again for the same solutions.
They are intended to work on my own system (Dell XPS, Arch Linux with Gnome).

## Settings standard apps for new filetypes
Most code-files are by default recognized as plain text. So the standard application for opening .cpp, .py or .qt files is always the same.
If you want to have a seperate default application for each of this types, you have to add a new mime type.

Create an xml
```
nano ~/.local/share/mime/packages/application-qt.xml
```

Edit the xml
```
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
    <mime-type type="application/qt">
        <comment>foo file</comment>
        <icon name="application-qt"/>
        <glob-deleteall/>
        <glob pattern="*.qt"/>
    </mime-type>
</mime-info>
```

And then update the MIME database:
```
update-mime-database ~/.local/share/mime
```

When opening the filetype the next time you are asked to choose a default app.


The detailed description can be found here [https://wiki.archlinux.org/index.php/XDG_MIME_Applications]
