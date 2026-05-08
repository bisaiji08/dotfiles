# フォントのソースディレクトリ
SRC_DIR="$HOME/dotfiles/fonts"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    FONT_DIR="$HOME/.local/share/fonts/HackGen"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    FONT_DIR="$HOME/Library/Fonts"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Windowsの場合
    echo "Windows detected. Copying fonts..."
    # ユーザーディレクトリのフォントフォルダ（Windows 10/11）
    FONT_DIR="/c/Users/$USER/AppData/Local/Microsoft/Windows/Fonts"
    mkdir -p "$FONT_DIR"
    cp "$SRC_DIR"/*.ttf "$FONT_DIR/"
    echo "NOTICE: On Windows, you might need to right-click and 'Install' the fonts manually from $FONT_DIR to register them in the registry."
else
    echo "Unknown OS: $OSTYPE"
fi

if [ -d "$SRC_DIR" ]; then
    mkdir -p "$FONT_DIR"
    cp "$SRC_DIR"/*.ttf "$FONT_DIR/"
    
    # Linux用キャッシュ更新
    if command -v fc-cache >/dev/null; then
        fc-cache -f
    fi
    echo "Fonts installed to $FONT_DIR"
else
    echo "Source font directory not found."
fi
