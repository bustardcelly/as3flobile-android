# License

See the accompanying LICENSE file.

# About

as3flobile-android is an extension library built against the [as3flobile library](http://github.com/bustardcelly/as3flobile) to provide the look-and-feel of controls targeting the Android platform. Along with graphics and skins, included are a handful of *convenience* extensions (such as AndroidScrollList) that handle wiring up the skins and graphic properties. These *convenience* extensions can be instantiated and used just like there extended counterparts.

# Requirements

The following libraries are required to compile the as3flobile-android library project:

## as3flobile

as3flobile is a set of ActionScript 3 components targeting the Flash Player on Mobile Devices, whether it be embedded in the browser or in an Adobe AIR application.

as3flobile aims to provide a set of components that function within the paradigm of a mobile user interface where a mouse and keyboard are not the primary source of interaction.

Visit the [main wiki page](http://wiki.github.com/bustardcelly/as3flobile/) for a full explanation and a list of the available controls.

To view a quick example of the components in as3flobile, point your Flash-enabled browser on *most* popular mobile devices to: [http://www.custardbelly.com/android/froyo/as3flobile/](http://www.custardbelly.com/android/froyo/as3flobile/)

# Library SWCs

The as3flobile-android project generates library SWCs into two output bins:

## standalone

The standalone bin contains the library SWC that can be added to the library
of a project without the need of having the dependant [as3flobile](http://github.com/bustardcelly/as3flobile/) and [as3-signals](http://github.com/robertpenner/as3-signals) libraries. 
The standalone [as3flobile-android swc](http://github.com/bustardcelly/as3flobile-android/tree/master/bin/standalone/), compiles in the as3flobile standalone library and the bits used from [as3-signals](http://github.com/robertpenner/as3-signals). 
As such, the file size for the standalone SWC is higher than the external library, as it has dependencies compiled in. 
If you are not worried about file size and/or you do not want to manage dependencies in your project library, 
use the standalone SWC or SWF.

## external

The external bin contains the library SWC that is compiled against dependant SWC libraries:
[as3flobile](http://github.com/bustardcelly/as3flobile/tree/master/bin/) and [as3-signals](http://github.com/robertpenner/as3-signals). Included in the external SWC are only the source files 
from the as3flobile-android library. As such, the file size for the external SWC is lower than the standalone
yet it is necessary to include the dependant libraries (as3flobile and [as3-signals](http://github.com/robertpenner/as3-signals)) within your project. If you are worried about
file size and/or are fine with managing library dependencies, use the external SWC or SWF.

# Attribution

## Graphics

The embedded graphics were graciously cut from a PSD made publicly available by Pavel Macek. The original PSD file can be found here: [http://www.matcheck.cz/androidguipsd/](http://www.matcheck.cz/androidguipsd/).

## ScaleBitmap

as3flobile uses the open-source [ScaleBitmap](http://www.bytearray.org/?p=118) class (with a slight modification) in order to properly scale the embedded graphics. A huge time-saver and a great little utility. Visit [http://www.bytearray.org/?p=118](http://www.bytearray.org/?p=118) to find out more. 