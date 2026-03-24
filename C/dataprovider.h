#ifndef DATAPROVIDER_H
#define DATAPROVIDER_H
#include <QObject>
#include <QVariantList>
#include <QUrl>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QFileInfoList>
#include <QDebug>
class DataProvider :public QObject {
    Q_OBJECT
    Q_PROPERTY(QString absolutePath READ absolutePath WRITE setabsolutePath NOTIFY absolutePathChanged FINAL)
public:
    explicit  DataProvider(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList getData(QUrl source,QVariantList searchList);
    Q_INVOKABLE QVariantList getDir(QUrl source);
    QString absolutePath() const;
    void setabsolutePath(const QString &newAbsolutePath);
signals:
    void absolutePathChanged();
private:
    QString m_absolutePath;
};

#endif // DATAPROVIDER_H
