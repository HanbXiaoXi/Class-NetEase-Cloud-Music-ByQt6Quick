#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H
#include <QObject>
#include <QDebug>
#include <QAudioOutput>
#include <QMediaPlayer>
#include <QTimer>
#include <QUrl>
#include <QFileInfo>
#include <QImage>
//需要的设置
/*

读取文件夹中的歌曲
根据url读取歌曲以及数据
返回歌曲图片以及信息
循环读取歌曲的播放时间
暂停，开始，切换歌曲

*/
class MusicPlayer :public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl filePath READ filePath WRITE setFilePath NOTIFY filePathChanged FINAL)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged FINAL)
    Q_PROPERTY(QString artist READ artist WRITE setArtist NOTIFY artistChanged FINAL)
    Q_PROPERTY(QString album READ album WRITE setAlbum NOTIFY albumChanged FINAL)
    Q_PROPERTY(QString timeDisplay READ timeDisplay WRITE setTimeDisplay NOTIFY timeDisplayChanged FINAL)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged FINAL)
    Q_PROPERTY(int progress READ progress WRITE setProgress NOTIFY progressChanged FINAL)
    Q_PROPERTY(QUrl image READ image WRITE setImage NOTIFY imageChanged FINAL)
public:
    explicit  MusicPlayer(QObject *parent = nullptr);
    Q_INVOKABLE void play(); //播放切换
    Q_INVOKABLE void changeProgress(const qfloat16 &newPosition);
    Q_INVOKABLE void setFilePath(const QUrl &newFilePath); //更改播放源
    Q_INVOKABLE QUrl returnImageUrl(const QImage& image); //输出图像url
    void updateValue(); //进度改变时
    void updateInfo() ; //元数据更新时
    void updateStatus(); //播放状态更新时
    QString title() const;
    void setTitle(const QString &newTitle);
    QString artist() const;
    void setArtist(const QString &newArtist);
    QString album() const;
    void setAlbum(const QString &newAlbum);
    QString timeDisplay() const;
    void setTimeDisplay(const QString &newTimeDisplay);
    int volume() const;
    void setVolume(int newVolume);
    int progress() const;
    void setProgress(int newProgress);
    QUrl filePath() const; //获取文件目录
    QUrl image() const;
    void setImage(const QUrl &newImage);

signals:
    void stop();
    void start();
    void titleChanged();
    void artistChanged();
    void albumChanged();
    void timeDisplayChanged();
    void volumeChanged();
    void progressChanged();
    void filePathChanged();
    void imageChanged();

private slots:

private:
    bool checkAudioFile();
    QMediaPlayer* m_player;
    QAudioOutput* m_audioOutput;
    QTimer* m_progressTimer;
    QString m_title;
    QString m_artist;
    QString m_album;
    QString m_timeDisplay;
    int m_volume;
    int m_progress;
    QUrl m_filePath;
    QUrl m_image;
};

#endif // MUSICPLAYER_H
