function sh_do_pre_pkg_install() { :; }

function sh_do_pkg_install() {
    python3 -m pip install -U \
        matplotlib \
        scipy \
        youtube-search-python \
        pyqt5==5.14.0
}

function sh_do_post_pkg_install() {
    pushd ~/ >/dev/null
    git clone https://github.com/opencv/opencv.git --branch 3.4.17
    git clone https://github.com/opencv/opencv_contrib.git --branch 3.4.17
    mkdir -p opencv/build
    pushd opencv/build >/dev/null
    cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -D BUILD_EXAMPLES=OFF ..
    make "-j$(grep -c '^processor' /proc/cpuinfo)"
    make install
    sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
    ldconfig
    mkdir -p "/home/${TARGET_USER}/.local/lib/python3.8/site-packages"
    ln -s "$(find /usr/local/lib/ -type f -name "cv2*.so")" "/home/${TARGET_USER}/.local/lib/python3.8/site-packages/cv2.so"
    popd >/dev/null
    popd >/dev/null
}

function sh_do_post_ws_merge() { :; }
