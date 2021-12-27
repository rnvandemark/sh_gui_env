# sh_gui_env

## Build instructions for our select ROS2 repos

```
python3 -m pip install -U \
  matplotlib \
  scipy \
  pyqt5==5.14.0

git clone https://github.com/opencv/opencv.git --branch 3.4.17
git clone https://github.com/opencv/opencv_contrib.git --branch 3.4.17
cd opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D WITH_TBB=ON -D WITH_V4L=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -D BUILD_EXAMPLES=ON ..
make -j4
sudo make install
sudo sh -c 'echo "/usr/local/lib" >> /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
ln -s "$(find /usr/local/lib/ -type f -name "cv2*.so")" /home/$USER/.local/lib/python3.8/site-packages/cv2.so

mkdir -p /path/to/your_ws/src
cd /path/to/your_ws
rosinstall src /path/to/sh_gui_env/sh_gui.rosinstall

# See sh_base_env for remaining build instructions

```
