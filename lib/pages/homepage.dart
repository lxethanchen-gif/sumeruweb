import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui_web' as ui;
import 'dart:html' as html;
import 'package:flutter_webrtc/flutter_webrtc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class LinkItem {
  final String title;
  final String url;
  LinkItem(this.title, this.url);
}

class _HomePageState extends State<HomePage> {
  // 將原本過亮的純黃改成質感深金/棕黃，在白底上字才看得清楚
  final Color _gold = const Color.fromARGB(255, 196, 154, 10);
  final List<String> _tabs = ['最新消息', '影音開示', '應世卷', '滅罪卷', '機緣道旨', '詩摘'];

  // ── WebRTC 與 錄影 相關變數 ──────────────────────────────────
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  MediaStream? _localStream;
  MediaRecorder? _mediaRecorder; // 錄影機
  
  bool _isWebRTCInitialized = false;
  bool _showLiveCamera = false;
  bool _isVideoOn = true;
  bool _isAudioOn = true;    // 錄影通常需要聲音，預設改為開啟
  bool _isRecording = false; // 是否正在錄影

  final Map<String, List<LinkItem>> _tabContent = {
    '最新消息': [
      LinkItem('2026年5月最新開示公告', 'https://example.com'),
      LinkItem('近期修持活動說明', 'https://example.com'),
    ],
    '影音開示': [
      LinkItem('諦深佛陀開示 2020年3月7日', 'https://youtu.be/2z26miBEBkA?si=tniG3_oNlKwL_MPx'),
      LinkItem('諦深佛陀開示 2020年3月14日', 'https://youtu.be/aYdmafP7HMY?si=Ou0Z3bsVhrlu8pFD'),
      LinkItem('諦深佛陀開示 2020年3月21日', 'https://youtu.be/3uGgjYDmhUA?si=J_bXQ_DS8w4jbC9l'),
    ],
    '應世卷': [LinkItem('應世卷第一章', 'https://example.com')],
    '滅罪卷': [LinkItem('滅罪卷導讀', 'https://example.com')],
    '機緣道旨': [LinkItem('機緣道旨要義', 'https://example.com')],
    '詩摘': [LinkItem('諦深佛陀詩集選讀', 'https://example.com')],
  };

  @override
  void initState() {
    super.initState();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'youtube-player',
      (int viewId) => html.IFrameElement()
        ..src = 'https://www.youtube.com/embed/gj4mSg0ElRA?autoplay=0'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allowFullscreen = true,
    );
  }

  // ── 啟動 WebRTC 鏡頭 ────────────────────────────────────────
  Future<void> _startWebRTC() async {
    try {
      if (!_isWebRTCInitialized) {
        await _localRenderer.initialize();
        _isWebRTCInitialized = true;
      }

      final Map<String, dynamic> mediaConstraints = {
        'audio': true,
        'video': {
          'facingMode': 'user',
          'width': {'ideal': 1280},
          'height': {'ideal': 720},
        },
      };

      MediaStream stream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
      _localStream = stream;
      _localRenderer.srcObject = _localStream;

      _localStream?.getVideoTracks().forEach((track) => track.enabled = _isVideoOn);
      _localStream?.getAudioTracks().forEach((track) => track.enabled = _isAudioOn);

      setState(() {
        _showLiveCamera = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('無法開啟鏡頭: $e')),
      );
    }
  }

  // ── 開始錄影功能 (已修正 Web 端參數語法) ─────────────────────────
  Future<void> _startRecording() async {
    if (_localStream == null) return;

    try {
      _mediaRecorder = MediaRecorder();
      
      // 修正：WebRTC 在網頁端直接傳入檔名路徑即可
      await _mediaRecorder!.start(
        'video-record.mp4', 
      );

      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print("錄影啟動失敗: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('錄影啟動失敗: $e')),
      );
    }
  }

  // ── 停止錄影並自動下載檔案 ─────────────────────────────────────
  Future<void> _stopRecording() async {
    if (_mediaRecorder == null || !_isRecording) return;

    try {
      await _mediaRecorder!.stop();
      setState(() {
        _isRecording = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('錄影結束，瀏覽器已自動下載影片檔！')),
      );
    } catch (e) {
      print("停止錄影失敗: $e");
    }
  }

  // ── 關閉鏡頭 ──────────────────────────────────────────────
  void _stopWebRTC() {
    if (_isRecording) _stopRecording(); // 如果正在錄影就先停止
    _localStream?.getTracks().forEach((track) => track.stop());
    _localStream = null;
    setState(() {
      _showLiveCamera = false;
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  void dispose() {
    _localStream?.getTracks().forEach((track) => track.stop());
    _localRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double contentWidth = w > 1100 ? 1000 : w * 0.95;

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: Colors.white, // 💡 底色改為純白色
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── 標題 ──────────────────────────────────────────
                Text(
                  '諦深佛陀 2026年5月29日 現場直播開示',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: w > 600 ? 32 : 24,
                    fontWeight: FontWeight.bold,
                    color: _gold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 16),

                // ── 直播切換控制按鈕 ────────────────────────────────
                ElevatedButton.icon(
                  onPressed: () {
                    if (_showLiveCamera) {
                      _stopWebRTC();
                    } else {
                      _startWebRTC();
                    }
                  },
                  icon: Icon(_showLiveCamera ? Icons.stop : Icons.sensors),
                  label: Text(_showLiveCamera ? '離開直播 (切回影音)' : '進入直播 (開啟相機)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showLiveCamera ? Colors.grey[700] : const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                const SizedBox(height: 24),

                // ── 顯示影音區塊 ──────────────────────────────────────
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(
                    width: contentWidth,
                    height: contentWidth * 9 / 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0), // 未開鏡頭時改為淡灰色背景，配合白底
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: _showLiveCamera
                        ? Stack(
                            children: [
                              // WebRTC 鏡頭畫面
                              RTCVideoView(
                                _localRenderer,
                                mirror: true,
                                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                              ),
                              if (!_isVideoOn)
                                Container(
                                  color: const Color(0xFF1E1E1E), // 修正：正確的深灰色
                                  child: const Center(
                                    child: Icon(Icons.videocam_off, size: 64, color: Colors.white54),
                                  ),
                                ),
                              
                              // ── 錄影狀態紅點提示 ──────────────────────
                              if (_isRecording)
                                Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(Icons.fiber_manual_record, color: Colors.white, size: 16),
                                        SizedBox(width: 4),
                                        Text('REC 正在錄影', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),

                              // ── 畫面下方控制小按鈕面板 ──────────────────
                              Positioned(
                                bottom: 16,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // 鏡頭開關
                                    CircleAvatar(
                                      backgroundColor: Colors.white.withOpacity(0.9),
                                      child: IconButton(
                                        icon: Icon(_isVideoOn ? Icons.videocam : Icons.videocam_off),
                                        color: _isVideoOn ? Colors.blue : Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            _isVideoOn = !_isVideoOn;
                                            _localStream?.getVideoTracks().forEach((t) => t.enabled = _isVideoOn);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // 麥克風開關 (錄音功能)
                                    CircleAvatar(
                                      backgroundColor: Colors.white.withOpacity(0.9),
                                      child: IconButton(
                                        icon: Icon(_isAudioOn ? Icons.mic : Icons.mic_off),
                                        color: _isAudioOn ? Colors.blue : Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            _isAudioOn = !_isAudioOn;
                                            _localStream?.getAudioTracks().forEach((t) => t.enabled = _isAudioOn);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // 自動錄影/停止並儲存 MP4 按鈕
                                    ElevatedButton.icon(
                                      onPressed: _isRecording ? _stopRecording : _startRecording,
                                      icon: Icon(_isRecording ? Icons.stop_circle : Icons.radio_button_checked),
                                      label: Text(_isRecording ? '停止並儲存' : '開始錄影'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _isRecording ? Colors.red[700] : Colors.green[600],
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : const HtmlElementView(viewType: 'youtube-player'),
                  ),
                ),
                const SizedBox(height: 50),

                // ── Tab 區塊 (明亮系白底適配) ──────────────────────────────
                SizedBox(
                  width: contentWidth,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: w < 600,
                        tabAlignment: w < 600 ? TabAlignment.start : TabAlignment.center,
                        dividerColor: Colors.transparent,
                        labelColor: Colors.black, // 選中時字體改為黑色
                        unselectedLabelColor: _gold,
                        indicator: BoxDecoration(
                          color: _gold.withOpacity(0.15), // 選中時的背景淡金黃色
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        tabs: _tabs
                            .map((title) => Tab(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      border: Border.all(color: _gold, width: 1.2),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 300,
                        child: TabBarView(
                          children: _tabs.map((tabTitle) {
                            final items = _tabContent[tabTitle] ?? [];
                            return ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return InkWell(
                                  onTap: () => _launchURL(item.url),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        color: _gold,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline, // 加上底線方便在白底識別連結
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}