#ifndef COLORCOMPONENTS_H
#define COLORCOMPONENTS_H

#include <iostream>
#include <string>
#include <sstream>

#include <QObject>
#include <QColor>

class ColorComponents : public QObject
{
	Q_OBJECT
	Q_PROPERTY(qreal alpha      READ alpha      WRITE setAlpha      NOTIFY alphaChanged)
	Q_PROPERTY(qreal red        READ red        WRITE setRed        NOTIFY redChanged)
	Q_PROPERTY(qreal blue       READ blue       WRITE setBlue       NOTIFY blueChanged)
	Q_PROPERTY(qreal green      READ green      WRITE setGreen      NOTIFY greenChanged)
	Q_PROPERTY(qreal hue        READ hue        WRITE setHue        NOTIFY hueChanged)
	Q_PROPERTY(qreal saturation READ saturation WRITE setSaturation NOTIFY saturationChanged)
	Q_PROPERTY(qreal value      READ value      WRITE setValue      NOTIFY valueChanged)
    Q_PROPERTY(QColor color     READ color      WRITE setColor      NOTIFY colorChanged)
    Q_PROPERTY(QString fullName READ fullName                       NOTIFY colorChanged)

public:
	ColorComponents(QObject *parent = 0);

	qreal alpha() const;
	void setAlpha(qreal alpha);

	qreal red() const;
	void setRed(qreal red);

	qreal blue() const;
	void setBlue(qreal blue);

	qreal green() const;
	void setGreen(qreal green);

	qreal hue() const;
	void setHue(qreal hue);

	qreal saturation() const;
	void setSaturation(qreal saturation);

	qreal value() const;
	void setValue(qreal value);
    
    QColor color() const;
    void setColor(const QColor &color);

    QString fullName() const;
    
    Q_INVOKABLE static bool isValidColor(const QString& name);
    Q_INVOKABLE static QColor hsva(qreal h, qreal s, qreal v, qreal a = 1.0);

private:
    inline qreal _inRange(qreal v) const;

signals:
	void alphaChanged();
	void redChanged();
	void blueChanged();
	void greenChanged();
	void hueChanged();
	void saturationChanged();
	void valueChanged();
	void colorChanged();

private:
	QColor m_color;
};

#endif // COLORCOMPONENTS_H