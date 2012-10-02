#include "colorcomponentsplugin.h"
#include "colorcomponents.h"
#include <qdeclarative.h>

void ColorComponentsPlugin::registerTypes(const char *uri)
{
	qmlRegisterType<ColorComponents>(uri, 1, 0, "ColorComponents");
}

Q_EXPORT_PLUGIN2(colorcomponentsplugin, ColorComponentsPlugin);