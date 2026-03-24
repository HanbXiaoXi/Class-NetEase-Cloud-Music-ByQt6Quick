#include "MusicPlayer.h"
#include <QDebug>
#include <qmediametadata.h>
#include <future>
#include <QBuffer>
#include <QByteArray>

MusicPlayer::MusicPlayer(QObject *parent):
    QObject(parent),
    m_player(new QMediaPlayer(this)),
    m_progressTimer(new QTimer(this)),
    m_progress(0),
    m_volume(80)
{
    m_title = "";
    m_artist = "";
    m_album = "";
    m_timeDisplay = "00  :00 / 00 :00";
    m_audioOutput = new QAudioOutput;  //输出对象
    m_audioOutput->setVolume(m_volume*0.01); // 输出对象设置初始音量
    m_player->setAudioOutput(m_audioOutput);
    connect(m_player, &QMediaPlayer::positionChanged, this, &MusicPlayer::updateValue); //连接位置更改对象
    connect(m_player, &QMediaPlayer::metaDataChanged, this, &MusicPlayer::updateInfo); //当歌曲信息更改时触发
    connect(m_player, &QMediaPlayer::mediaStatusChanged,this,&MusicPlayer::updateStatus);
}

void MusicPlayer::play()
{
    if(m_player->isPlaying()){
        m_player->pause();
        emit stop();
    }else{
        m_player->play();
        emit start();
    }
}

void MusicPlayer::changeProgress(const qfloat16 &newPosition)
{
    m_player->setPosition(newPosition /1000 * m_player->duration());
    qDebug() << m_player->position();
}
///////
/// \brief MusicPlayer::updateValue
/////
void MusicPlayer::updateValue(){
    qint64 position = m_player->position();
    qint64 duration = m_player->duration();
    int seconds = position / 1000;
    int totalSeconds = duration / 1000;
    QString newTimeDisplay = QString("%1:%2 / %3:%4")
                                 .arg(seconds / 60, 2, 10, QLatin1Char('0'))
                                 .arg(seconds % 60, 2, 10, QLatin1Char('0'))
                                 .arg(totalSeconds / 60, 2, 10, QLatin1Char('0'))
                                 .arg(totalSeconds % 60, 2, 10, QLatin1Char('0'));
    setTimeDisplay(newTimeDisplay);
    setProgress( m_player->position() *1000 / m_player->duration());
    // qDebug() << m_player->metaData().value(QMediaMetaData::Title);
    // qDebug() << timeDisplay();
    // qDebug() << progress();
}
void MusicPlayer::setFilePath(const QUrl &newFilePath)
{
    if (m_filePath == newFilePath)
        return;
    m_filePath = newFilePath;
    //停止音乐
    if(m_player->isPlaying()){
        m_player->pause();
    }

    //检测文件是否存在
    if (checkAudioFile()) {
        qDebug()<<"音频文件检查正常，准备就绪";
    } else {
        qDebug()<< "文件不可用";
        m_title = "文件不可用";
        emit titleChanged();
        return;
    }
    //导入新文件位置
    m_player->setSource(m_filePath);
    qDebug() << QUrl(m_filePath);
    // while(m_player->mediaStatus() != QMediaPlayer::StalledMedia){
    // } //等待加载完成


    play();
    emit filePathChanged();
}


//将image转换为url发给qml
QUrl imageToUrl(const QImage& image)
{
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    image.scaled(80,80).save(&buffer, "png");
    QString base64 = QString::fromUtf8(byteArray.toBase64());
    return QString("data:image/png;base64,") + base64;
}
QUrl MusicPlayer::returnImageUrl(const QImage &image)
{

    return imageToUrl(image);
}
void MusicPlayer::updateInfo()
{
    //更新 title artist album
    qDebug() << m_player->metaData().keys(); //显示所有能够提取的信息的key值
    setTitle(m_player->metaData().value(QMediaMetaData::Title).toString());
    setArtist(m_player->metaData().value(QMediaMetaData::ContributingArtist).toString());
    setAlbum(m_player->metaData().value(QMediaMetaData::AlbumTitle).toString());
    qDebug() << m_title;
    qDebug() << m_artist;
    qDebug() << m_album;
    QVariant coverArt = m_player->metaData().value(QMediaMetaData::ThumbnailImage);
    if (coverArt.isValid() && coverArt.canConvert<QImage>()) {
        QImage image = coverArt.value<QImage>();
        qDebug() << "封面图片已加载，尺寸:" << image.size();
        setImage(imageToUrl(image));
    }
}

void MusicPlayer::updateStatus()
{
    if(m_player->mediaStatus() == QMediaPlayer::EndOfMedia){

    }
}






QUrl MusicPlayer::filePath() const
{
    return m_filePath;
}


QString MusicPlayer::title() const
{
    return m_title;
}

void MusicPlayer::setTitle(const QString &newTitle)
{
    if (m_title == newTitle)
        return;
    m_title = newTitle;
    emit titleChanged();
}

QString MusicPlayer::artist() const
{
    return m_artist;
}

void MusicPlayer::setArtist(const QString &newArtist)
{
    if (m_artist == newArtist)
        return;
    m_artist = newArtist;
    emit artistChanged();
}

QString MusicPlayer::album() const
{
    return m_album;
}

void MusicPlayer::setAlbum(const QString &newAlbum)
{
    if (m_album == newAlbum)
        return;
    m_album = newAlbum;
    emit albumChanged();
}

QString MusicPlayer::timeDisplay() const
{
    return m_timeDisplay;
}

void MusicPlayer::setTimeDisplay(const QString &newTimeDisplay)
{
    if (m_timeDisplay == newTimeDisplay)
        return;
    m_timeDisplay = newTimeDisplay;
    emit timeDisplayChanged();
}

int MusicPlayer::volume() const
{
    return m_volume;
}

// 更改volume值
void MusicPlayer::setVolume(int newVolume)
{
    if (m_volume == newVolume)
        return;
    m_volume = newVolume;
    if (m_volume == 0){
        m_audioOutput->setMuted(true);
        emit volumeChanged();
        return;
    }
    m_audioOutput->setMuted(false);
    m_audioOutput->volumeChanged(m_volume*0.01);
    qDebug() << m_audioOutput->volume() ;
    emit volumeChanged();
}

int MusicPlayer::progress() const
{
    return m_progress;
}

void MusicPlayer::setProgress(int newProgress)
{
    if (m_progress == newProgress)
        return;
    m_progress = newProgress;
    emit progressChanged();
}

bool MusicPlayer::checkAudioFile()
{
    QFileInfo fileInfo(m_filePath.toString().mid(8));
    if (!fileInfo.exists()) {
        qDebug() << "错误：文件不存在";
        return false;
    }

    if (fileInfo.size() == 0) {
        qDebug() << "警告：文件为空";
        return false;
    }

    qDebug() << "找到音频文件："<<m_filePath << "(" << fileInfo.size() << " 字节)";
    return true;
}



QUrl MusicPlayer::image() const
{
    return m_image;
}

void MusicPlayer::setImage(const QUrl &newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}
