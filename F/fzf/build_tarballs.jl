# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder, Pkg

name = "fzf"
version = v"0.22.0"

# Collection of sources required to complete build
sources = [
    GitSource("https://github.com/junegunn/fzf.git", "e2ae1b249cf2d5258b552cfd682c7c0911981e9b")
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd fzf/
mkdir -p ${bindir}
go build -o ${bindir}
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products = [
    ExecutableProduct("fzf", :fzf)
]

# Dependencies that must be installed before this package can be built
dependencies = Dependency[
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; compilers = [:go])
