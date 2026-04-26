python -m venv .venv --system-site-packages
source /workspaces/fix-resume-works/.venv/bin/activate
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip config set global.trusted-host pypi.tuna.tsinghua.edu.cn
echo "source /workspaces/fix-resume-works/.venv/bin/activate" >> ~/.bashrc
# export CC="ccache clang"
# export CXX="ccache clang++"
apt update
apt install linux-tools-generic linux-tools-common
ln -s /usr/lib/linux-tools/6.8.0-110-generic/perf /usr/local/bin/perf