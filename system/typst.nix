{ pkgs, lib, ... } : let

  # Typst's svg2pdf has issues:
  #   https://github.com/typst/typst/issues/1421
  # Also cannot directly embed pdf image:
  #   https://github.com/typst/typst/issues/145
  # Hence this script
  # - convert svg to pdf using chromium:
  #     https://gist.github.com/asmeurer/b9851296578743db7c0e985939a462d9
  # - then convert pdf back to svg using pdf2svg
  #     https://github.com/typst/typst/issues/145#issuecomment-1483981195
  typst-fix-svg = pkgs.writeShellScriptBin "typst-fix-svg" ''
    if [ $# -ne 2 ]; then
      echo "Usage: typst-fix-svg input.svg output.svg" 1>&2
      exit 1
    fi

    INPUT=$1
    OUTPUT=$2

    HTML="
    <html>
      <head>
        <style>
    body {
      margin: 0;
    }
        </style>
        <script>
    function init() {
      const element = document.getElementById('targetsvg');
      const positionInfo = element.getBoundingClientRect();
      const height = positionInfo.height;
      const width = positionInfo.width;
      const style = document.createElement('style');
      style.innerHTML = \`@page {margin: 0; size: \''${width}px \''${height}px}\`;
      document.head.appendChild(style);
    }
    window.onload = init;
        </script>
      </head>
      <body>
        <img id=\"targetsvg\" src=\"''${INPUT}\">
      </body>
    </html>
    "

    tmp_html=$(mktemp --tmpdir XXXXXX.html)
    tmp_pdf=$(mktemp --tmpdir XXXXXX.pdf)
    trap "rm -f $tmp_html $tmp_pdf" EXIT

    echo $HTML > "$tmp_html"
    ${pkgs.chromium}/bin/chromium --headless --disable-gpu --print-to-pdf="$tmp_pdf" "$tmp_html"
    ${pkgs.pdf2svg}/bin/pdf2svg "$tmp_pdf" "$OUTPUT"
  '';

in {
  environment.systemPackages = with pkgs; [
    typst
    myRepo.typst-svg-emoji
    entr
  ] ++ [
    typst-fix-svg
  ];
  hm = [({ ... }: {
    xdg.dataFile."typst".source = "${pkgs.myRepo.typst-svg-emoji}/share/typst";
  })];

}
