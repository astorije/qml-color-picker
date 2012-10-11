#include "colorcomponents.h"

ColorComponents::ColorComponents(QObject *parent)
	: QObject(parent)
{
}

qreal ColorComponents::alpha() const
{
	return m_color.alphaF();
}

void ColorComponents::setAlpha(qreal alpha)
{
	if(_inRange(alpha) == this->alpha()) return;

	m_color.setAlphaF(_inRange(alpha));
	
    emit alphaChanged();

    emit colorChanged();
}

qreal ColorComponents::red() const
{
	return m_color.redF();
}

void ColorComponents::setRed(qreal red)
{
	if(_inRange(red) == this->red()) return;

	m_color.setRedF(_inRange(red));
	
    emit redChanged();
		
	emit hueChanged();
	emit saturationChanged();
	emit valueChanged();

    emit colorChanged();
}

qreal ColorComponents::blue() const
{
	return m_color.blueF();
}

void ColorComponents::setBlue(qreal blue)
{
	if(_inRange(blue) == this->blue()) return;

	m_color.setBlueF(_inRange(blue));
	
    emit blueChanged();
		
	emit hueChanged();
	emit saturationChanged();
	emit valueChanged();

    emit colorChanged();
}

qreal ColorComponents::green() const
{
	return m_color.greenF();
}

void ColorComponents::setGreen(qreal green)
{
	if(_inRange(green) == this->green()) return;
	
    m_color.setGreenF(_inRange(green));
	
    emit greenChanged();
		
	emit hueChanged();
	emit saturationChanged();
	emit valueChanged();

    emit colorChanged();
}

qreal ColorComponents::hue() const
{
    return _inRange(m_color.hueF());
}

void ColorComponents::setHue(qreal hue)
{
	if(_inRange(hue) == this->hue()) return;

	m_color.setHsvF(_inRange(hue), saturation(), value(), alpha());
	
    emit hueChanged();

	emit redChanged();
	emit blueChanged();
	emit greenChanged();

    emit colorChanged();
}

qreal ColorComponents::saturation() const
{
	return m_color.saturationF();
}

void ColorComponents::setSaturation(qreal saturation)
{
	if(_inRange(saturation) == this->saturation()) return;

	m_color.setHsvF(hue(), _inRange(saturation), value(), alpha());

	emit saturationChanged();

	emit redChanged();
	emit blueChanged();
	emit greenChanged();

    emit colorChanged();
}

qreal ColorComponents::value() const
{
	return m_color.valueF();
}

void ColorComponents::setValue(qreal value)
{
	if(_inRange(value) == this->value()) return;

	m_color.setHsvF(hue(), saturation(), _inRange(value), alpha());

	emit valueChanged();

	emit redChanged();
	emit blueChanged();
	emit greenChanged();

    emit colorChanged();
}

QColor ColorComponents::color() const
{
    return m_color;
}

void ColorComponents::setColor(const QColor &color)
{
    if(!color.isValid() || color == this->color()) return;
    
    m_color = color;

    emit colorChanged();
    
    emit hueChanged();
    emit saturationChanged();
    emit valueChanged();
    
    emit redChanged();
    emit greenChanged();
    emit blueChanged();
    
    emit alphaChanged();
}

QString ColorComponents::fullName() const
{
    if(alpha() == 1.0)
        return m_color.name();
    else
        return QString("#%1").arg(m_color.alpha(), 2, 16, QChar('0')) + m_color.name().mid(1);
}

bool ColorComponents::isValidColor(const QString& name)
{
    return QColor::isValidColor(name);
}

QColor ColorComponents::hsva(qreal h, qreal s, qreal v, qreal a)
{
    return QColor::fromHsvF(h, s, v, a);
}

qreal ColorComponents::_inRange(qreal v) const
{
    if(v < 0.0)
        return 0.0;
    else if(v > 1.0)
        return 1.0;
    else
        return v;
}