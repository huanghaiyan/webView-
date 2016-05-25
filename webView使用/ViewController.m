//
//  ViewController.m
//  webView使用
//
//  Created by 黄海燕 on 16/5/9.
//  Copyright © 2016年 huanghy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView* webView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建UIWebView
    CGRect bounds = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height - 100);
    webView = [[UIWebView alloc]initWithFrame:bounds];
    //设置属性
    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    [webView setUserInteractionEnabled:YES];//是否支持交互
    //加载网络资源
    NSURL *url = [NSURL URLWithString:@"http://news.163.com/16/0525/09/BNTC1B7O00014PRF.html"];//创建url（统一资源定位符，互联网标准资源的地址）
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];//创建NSURLRequest
    [webView loadRequest:urlRequest];//加载
    /*
     //加载本地资源
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"jpg"];//本地资源路径
    NSURL* localUrl = [NSURL fileURLWithPath:filePath];//创建本地资源URL
    NSURLRequest* request = [NSURLRequest requestWithURL:localUrl];//创建NSURLRequest
    [webView loadRequest:request];//加载

     */
    //设置代理
    webView.delegate = self;
    
    //创建回退按钮
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, self.view.bounds.size.height - 80, 80, 50)];
    [btn setTitle:@"回退" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //前进按钮
    UIButton *goForwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(325, self.view.bounds.size.height - 80, 80,50)];
    [goForwardBtn setTitle:@"前进" forState:UIControlStateNormal];
    goForwardBtn.backgroundColor = [UIColor lightGrayColor];
    [goForwardBtn addTarget:self action:@selector(goforward) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goForwardBtn];
    
    //重新加载按钮
    UIButton *reloadBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, self.view.bounds.size.height - 80, 80, 50)];
    [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    reloadBtn.backgroundColor = [UIColor lightGrayColor];
    [reloadBtn addTarget:self action:@selector(reloaddata) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reloadBtn];
    //显示webView
    [self.view addSubview:webView];

}

-(void)goback
{
    [webView goBack];
}

-(void)goforward
{
    [webView goForward];
}

-(void)reloaddata
{
    [webView reload];
}

//当返回值为NO，表示不允许加载此请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
//当WebView已经开始加载一个请求后，得到通知。
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"didStart");
}
//当WebView完成加载一个请求之后，得到通知
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取网页title
    NSString *titleHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"titleHtmlInfo------------:%@",titleHtmlInfo);
    //获取到得网页内容
    
    NSString *allHtmlInfo = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
    
    NSLog(@"allHtmlInfo****************%@",allHtmlInfo);
    
    NSLog(@"finish");
}
//当WebView在请求加载中发生错误时，得到通知。提供一个NSSError对象，以标识所发生错误类型。
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
