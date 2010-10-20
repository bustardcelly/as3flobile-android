# About

The as3flobile-android project generates library SWCs into two output bins:

## standalone

The standalone bin contains the library SWC that can be added to the library
of a project without the need of having the dependant [as3flobile](http://github.com/bustardcelly/as3flobile/) library. 
The standalone [as3flobile-android swc](http://github.com/bustardcelly/as3flobile-android/tree/master/bin/standalone/), compiles in the as3flobile standalone library. 
As such, the file size for the standalone SWC is higher than the external library, as it has dependencies compiled in. 
If you are not worried about file size and/or you do not want to manage dependencies in your project library, 
use the standalone SWC or SWF.

## external

The external bin contains the library SWC that is compiled against dependant SWC libraries:
[as3flobile](http://github.com/bustardcelly/as3flobile/tree/master/bin/). Included in the external SWC are only the source files 
from the as3flobile-android library. As such, the file size for the external SWC is lower than the standalone
yet it is necessary to include the dependant libraries (as3flobile) within your project. If you are worried about
file size and/or are fine with managing library dependencies, use the external SWC or SWF.

# Dependencies

The as3flobile library depends on the following libraries in order to compile:

## as3couchdb

The as3flobile-android library is built against the [standalone version](http://github.com/bustardcelly/as3flobile/tree/master/bin/) of [as3flobile](http://github.com/bustardcelly/as3flobile).