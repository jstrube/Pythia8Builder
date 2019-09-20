# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "Pythia8Builder"
version = v"0.1.0"

# Collection of sources required to build Pythia8Builder
sources = [
    "http://home.thep.lu.se/~torbjorn/pythia8/pythia8243.tgz" =>
    "f8ec27437d9c75302e192ab68929131a6fd642966fe66178dbe87da6da2b1c79",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/pythia8243/
./configure --prefix=$prefix --enable-shared
make -j $nproc
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc),
    Linux(:x86_64, libc=:musl),
    MacOS(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libpythia8", :libpythia8)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

