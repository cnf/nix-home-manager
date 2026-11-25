{
  lib,
  python3Packages,
  fetchFromGitHub,
  qt5,
  ffmpeg,
  procps,
}:

python3Packages.buildPythonApplication {
  pname = "thermal-camera-viewer";
  version = "3.3.0-unstable-2026-09-21";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "skywalker1905";
    repo = "thermal-camera-viewer";
    rev = "512b46e7d0701c05bfecc5cb096061c5967be860";
    hash = "sha256-6y+xbyHz9g98jIUm7BslC58fQxWOd6vK6c+QZZmCO5E=";
  };

  build-system = [ python3Packages.hatchling ];

  nativeBuildInputs = [ qt5.wrapQtAppsHook ];
  buildInputs = [ qt5.qtbase qt5.qtwayland ];

  dependencies = with python3Packages; [
    numpy
    opencv4 # provides cv2; upstream asks for opencv-python-headless
    pyusb
    pyqt5
  ];

  pythonRemoveDeps = [ "opencv-python-headless" ];

  # Single wrapper: Qt env + ffmpeg (recording) + pgrep (viewer/driver handoff).
  dontWrapQtApps = true;
  preFixup = ''
    makeWrapperArgs+=(
      "''${qtWrapperArgs[@]}"
      --prefix PATH : ${lib.makeBinPath [ ffmpeg procps ]}
      --add-flags "--model p1"
    )
  '';

  postInstall = ''
    install -Dm644 data/thermal-camera-viewer.desktop -t $out/share/applications
    for s in 48 128 256; do
      install -Dm644 data/thermal-camera-viewer-$s.png \
        $out/share/icons/hicolor/''${s}x''${s}/apps/thermal-camera-viewer.png
    done

    # USB access for Thermal Master P3/P1 (upstream's hotplug RUN+= script is omitted).
    install -Dm644 /dev/stdin $out/lib/udev/rules.d/70-thermal-camera-viewer.rules <<'EOF'
    SUBSYSTEM=="usb", ATTR{idVendor}=="3474", ATTR{idProduct}=="45a2", MODE="0660", GROUP="video", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTR{idVendor}=="3474", ATTR{idProduct}=="45c2", MODE="0660", GROUP="video", TAG+="uaccess"
    EOF
  '';

  pythonImportsCheck = [ "thermal_camera_viewer.p3_camera" ];

  meta = {
    description = "Viewer and v4l2loopback virtual webcam for Thermal Master P3/P1 cameras";
    homepage = "https://github.com/skywalker1905/thermal-camera-viewer";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux;
    mainProgram = "thermal-camera-viewer";
  };
}
