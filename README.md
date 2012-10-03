qmlcolorpicker
==============

A colorpicker made using QtQuick/QML and C++ components.

The C++ component allows the selected color to be edited from both the sliders **and** the text fields, which could not have been achieved using pure QML.

Installation
------------

This project has been fully tested with Qt 4.8.2 (QtQuick 1.1).

It relies on a C++ plugin for QtQuick (that is, a DLL built upon some C++ files).

Enter the 'colorcomponentsplugin' directory and run either:

`qmake && make install`

or:

`qmake && nmake release` for MSVC (you need to run it from the Visual Studio Command Prompt to have the environment properly set)

It will create a 'plugin' folder containing the plugin DLL mentioned in the 'qmldir' file.

Usage
-----

Simply run ColorPicker.qml with the Qt qmlviewer tool.