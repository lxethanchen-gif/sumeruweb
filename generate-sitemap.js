const { SitemapStream, streamToPromise } = require('sitemap');
const { createWriteStream } = require('fs');

// 1. 定義您的 Flutter Web 路由清單
const links = [
  { url: '/', changefreq: 'daily', priority: 1.0 },
  { url: '/dharma-realize', changefreq: 'monthly', priority: 0.9 },
  { url: '/ying-shi-juan', changefreq: 'monthly', priority: 0.8 },
  { url: '/mie-zui-juan', changefreq: 'monthly', priority: 0.8 },
  { url: '/ji-yuan-dao-zhi', changefreq: 'monthly', priority: 0.8 },
  { url: '/shi-zhai', changefreq: 'monthly', priority: 0.8 },
  { url: '/video-teachings', changefreq: 'monthly', priority: 0.8 },
  { url: '/resource-links', changefreq: 'monthly', priority: 0.6 },
  { url: '/buddha-intro', changefreq: 'monthly', priority: 0.7 },
  { url: '/live-stream', changefreq: 'monthly', priority: 0.9 },
];

const smStream = new SitemapStream({ hostname: 'https://sumeruweb.web.app' }); // 換成您的網域
const writeStream = createWriteStream('./build/web/sitemap.xml'); // 直接輸出到編譯後的目錄

smStream.pipe(writeStream);
links.forEach(link => smStream.write(link));
smStream.end();

streamToPromise(smStream).then(() => console.log('Sitemap 生成成功！'));