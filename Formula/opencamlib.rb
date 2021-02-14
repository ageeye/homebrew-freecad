class Opencamlib < Formula
  desc "Computer Aided Manufacturing libraries"
  homepage "http://www.anderswallin.net/CAM/"
  version "0.0.1" # TODO Specify a real version here - note usage below
 
  head do
    url "https://github.com/aewallin/opencamlib.git"
  end

  stable do
    url "https://github.com/aewallin/opencamlib.git",
        revision: "c3f3555270024104c51b27c33ecc7a293aae5dff"

    patch :p0 do
      url "https://raw.githubusercontent.com/vejmarie/patches/f665f103e1e9d09eb080bfb9cddf36710891761d/OpenCAMlib/fix_mac.patch"
      sha256 "e49a5a9ab1698019c53656f3ca6625db1b40012147998fd9b35f467917897295"
    end
  end

  depends_on "#@tap/python3.9" => :build
  depends_on "cmake" => :build
  depends_on "#@tap/boost@1.75.0" => :build
  depends_on "#@tap/boost-python3@1.75.0" => :build

  bottle do
    root_url "https://dl.bintray.com/vejmarie/freecad"
    cellar :any
    sha256 "8e81823c6b42837caf46f39f7ffae2d217e8080bd5cc21ff9092918e173e8c59" => :big_sur
    sha256 "695a0c707cc565aaa181049a2958e80fcaf21a76c573983e9d1314a19e90c8bd" => :catalina
  end

  def install
      args = std_cmake_args
      system "cmake", *args, "-DVERSION_STRING=#{version}", "-DBUILD_TYPE=Release", "-DUSE_OPENMP=0", "-DBUILD_PY_LIB=ON","-DUSE_PY_3=TRUE", "-DPYTHON_VERSION_SUFFIX=3", "-DCMAKE_PREFIX_PATH=" + Formula["#@tap/boost@1.75.0"].opt_prefix+ "/lib/cmake;" + Formula["#@tap/boost-python3@1.75.0"].opt_prefix+ "/lib/cmake;",  "."
      system "make", "-j#{ENV.make_jobs}", "install"
  end
end
