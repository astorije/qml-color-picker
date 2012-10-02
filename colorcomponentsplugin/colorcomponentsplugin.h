#include <QDeclarativeExtensionPlugin>

class ColorComponentsPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT
public:
    void registerTypes(const char *uri);
};