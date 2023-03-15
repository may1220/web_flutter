import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  WebViewPage({super.key});
  late final WebViewController _controller;

  static const String = '''
<!doctype html>
<html>
    <head>
        <!-- 
            このHTMLはPDFに変換する前提で書いているため、書き方として最適でない書き方となっています。
            修正する際は、PDFに変換した結果も併せて確認するようにしてください。
            ※以下で確認
            xhtml2pdf -s templates/8/001_pledge_document.html 
         -->
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <style type="text/css">
            / xhtml2pdfでのデフォルトCSS /
            html {
                font-family: Helvetica;
                font-size: 10px;
                font-weight: normal;
                color: #000000;
                background-color: transparent;
                margin: 0;
                padding: 0;
                line-height: 150%;
                border: 1px none;
                display: inline;
                width: auto;
                height: auto;
                white-space: normal;
            }

            b,
            strong {
                font-weight: bold;
            }

            i,
            em {
                font-style: italic;
            }

            u {
                text-decoration: underline;
            }

            s,
            strike {
                text-decoration: line-through;
            }

            a {
                text-decoration: underline;
                color: blue;
            }

            ins {
                color: green;
                text-decoration: underline;
            }
            del {
                color: red;
                text-decoration: line-through;
            }

            pre,
            code,
            kbd,
            samp,
            tt {
                font-family: "Courier New";
            }

            h1,
            h2,
            h3,
            h4,
            h5,
            h6 {
                font-weight:bold;
                -pdf-outline: true;
                -pdf-outline-open: false;
            }

            h1 {
                /*18px via YUI Fonts CSS foundation*/
                font-size:138.5%;
                -pdf-outline-level: 0;
            }

            h2 {
                /*16px via YUI Fonts CSS foundation*/
                font-size:123.1%;
                -pdf-outline-level: 1;
            }

            h3 {
                /*14px via YUI Fonts CSS foundation*/
                font-size:108%;
                -pdf-outline-level: 2;
            }

            h4 {
                -pdf-outline-level: 3;
            }

            h5 {
                -pdf-outline-level: 4;
            }

            h6 {
                -pdf-outline-level: 5;
            }

            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            p,
            pre,
            hr {
                margin:1em 0;
            }

            address,
            blockquote,
            body,
            center,
            dl,
            dir,
            div,
            fieldset,
            form,
            h1,
            h2,
            h3,
            h4,
            h5,
            h6,
            hr,
            isindex,
            menu,
            noframes,
            noscript,
            ol,
            p,
            pre,
            table,
            th,
            tr,
            td,
            ul,
            li,
            dd,
            dt,
            pdftoc {
                display: block;
            }

            table {
            }

            tr,
            th,
            td {
            
                vertical-align: middle;
                width: auto;
            }

            th {
                text-align: center;
                font-weight: bold;
            }

            center {
                text-align: center;
            }

            big {
                font-size: 125%;
            }

            small {
                font-size: 75%;
            }


            ul {
                margin-left: 1.5em;
                list-style-type: disc;
            }

            ul ul {
                list-style-type: circle;
            }

            ul ul ul {
                list-style-type: square;
            }

            ol {
                list-style-type: decimal;
                margin-left: 1.5em;
            }

            pre {
                white-space: pre;
            }

            blockquote {
                margin-left: 1.5em;
                margin-right: 1.5em;
            }

            noscript {
                display: none;
            }
        </style>
        <style type="text/css">
            @page {
                size: a4 portrait;
                @frame content_frame {
                    left: 30pt;
                    right: 30pt;
                    top: 15pt;
                    bottom: 10pt;
                }
            }
            html, body {
              font-family: HeiseiMin-W3;
                font-size: 15px;
                background-color: white;
                color: black;
            }
            body{
                width: 720px;
                margin: auto;
                margin-top: 15px;
                -pdf-word-wrap: CJK;
            }
            table{
                display: table;
            }
            tr{
                  line-height: 30px;
                  display: table-row;
            }
            td{
                display: table-cell;
            }
            ul{
                list-style-type: none;
                margin-top: 0px;
                margin-bottom: 0px;
            }
            ul ul {
                list-style-type: none;
            }
            .title{
                text-align: center;
            }
            .header_row{
                line-height: 25px;
            }
            .header_row_contents{
                width: 470px;
                overflow-wrap:normal
                
            }
            .contents_row_header{
                vertical-align: top;
                width: 15px;
            }
            .footer{
                width: 100%;
                table-layout:fixed; 

            }
            .footer_row{
                line-height: 25px;
            }
            .footer_row_margin{
                text-align: left;
            }
            .footer_row_header{
                text-align: left;
                vertical-align: top;
                width:80px;
                white-space:nowrap;
            }
            .footer_row_value{
                text-align: left;
                width: 380px;
            }
        </style>
    </head>
    <body>
    <table width="100%">
            <tr class="header_row"><td class="header_row_contents">8_name　9_name</td><td style="vertical-align: top;text-align: right;" >2023年03月13日</td></tr>
            <tr class="header_row"><td class="header_row_contents">ブライセンミャンマー確認用現場あ</td><td></td></tr>
            <tr class="header_row"><td class="header_row_contents">ミャンマー所長　所長　殿<td></td></tr>
        </table>
        <p class="title">作業員用スマートフォン利用申請書（兼　誓約書）</p>
        <p>貴社から貸与されたスマートフォン（以下、貸与機器）の利用にあたり、必要事項の申請と以下注意事項へ誓約いたします。</p>
        <p>
            <table >
                <tr><td class="contents_row_header">■</td>
                    <td>貸与機器情報
                        <ul>
                            <li >電話番号　070-5404-5389</li>
                        </ul>
                    </td>
                </tr>
                <tr><td class="contents_row_header">■</td>
                    <td>貸与機器の利用時に以下の対応をします。
                        <ul>
                            <li>・パスコードは他人に教えない</li>
                            <li>・機器を改造しない</li>
                            <li>・OSのアップデートなど指示を受けた場合は、速やかに対応します。</li>
                        </ul>
                    </td>
                </tr>
                <tr><td class="contents_row_header">■</td><td>貸与機器は常に肌身離さず持ち歩き、紛失、盗難、破損等がないよう十分に注意します。また、場内では機器の落下防止措置を講じます。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貴社の許可なく、貸与された現場外に貸与機器を持ち出しません。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貴社が貸与機器の位置情報を取得することに同意します。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貸与機器の利用は現場業務に限るものとし、私的利用は行ないません。また、撮影や録音した写真・動画等、貸与機器に入力・表示したデータは業務情報として扱い、貴社の許可なくインターネット上のサービスへの投稿、第三者への転送及び他のデバイス等への保存をいたしません。</td></tr>
                <tr><td class="contents_row_header">■</td><td>情報漏洩の調査等で貴社が必要と認めた場合は、貸与機器を提出し、当該機器内に記録されている、私的なものを含む一切のデータ(復元した削除データを含む)を貴社が閲覧・複写することに応じます。</td></tr>
                <tr><td class="contents_row_header">■</td><td>貸与機器が紛失又は盗難に遭った際は、速やかに現場担当者に報告すると共に情報漏洩を未然に防ぐ措置を講じます。また、紛失時の状況と対処について、決められた形式で直ちに報告します。</td></tr>
                <tr><td class="contents_row_header"></td><td>※意図的な紛失時には所属会社に対して弁済を求める場合があります。</td></tr>
                <tr><td class="contents_row_header">■</td><td>当現場の業務を終了する際には、貸与機器を返却いたします。</td></tr>
            </table>
        </p>

        
        <table class="footer">
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">一次会社名</td><td class="footer_row_value">BrcMM</td></tr>
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">所属会社名</td><td class="footer_row_value">BrcMM</buildee_worker_name_kana></td></tr>
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">(フリガナ)</td><td class="footer_row_value">サギョウイン メイ</buildee_worker_name></td></tr>
            <tr class="footer_row"><td class="footer_row_margin"></td><td class="footer_row_header">申請者   </td><td class="footer_row_value">作業員 May</td></tr>
        </table>
    </body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
