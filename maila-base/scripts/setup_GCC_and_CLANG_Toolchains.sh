#!/bin/bash
# @file   install_llvm_toolchain.sh
# @author Valerio Magnago [valerio.magnago@gmail.com]
#
# Copyright (c) 2020 Valerio Magnago and Paolo Tomasin, all rights reserved

# the material is adapted from https://gist.github.com/bhaskarvk/78a80d9b5d308c84ba43b4a4e599a439

# Define style for print
BOLD='\033[1m'
#RED='\033[0;31m'
#BLUE='\033[0;34m'
GREEN='\033[32m'
WHITE='\033[34m'
#YELLOW='\033[33m'
NO_COLOR='\033[0m'
export TAB="    " # 4 spaces

function info() {
  (>&2 echo -e "[${WHITE}${BOLD}INFO${NO_COLOR}] $*")
}

function print_delim() {
  echo "=============================================="
}


###
function register_gcc_version {
  local version=$1
  local priority=$2
  
  info "  |  |--> Registering gcc version ${version} with priority ${priority}"  
  apt install -yqq "gcc-${version}" "g++-${version}" "gfortran-${version}" "cpp-${version}"
  
  # GCC ${version}.x
  update-alternatives \
        --install /usr/bin/gcc   gcc   "/usr/bin/gcc-${version}"     "${priority}" \
        --slave   /usr/bin/g++ g++ "/usr/bin/g++-${version}"  \
        --slave   /usr/bin/gfortran gfortran "/usr/bin/gfortran-${version}"  \
        --slave   /usr/bin/gcc-nm gcc-nm "/usr/bin/gcc-nm-${version}"  \
        --slave   /usr/bin/gcc-ar gcc-ar "/usr/bin/gcc-ar-${version}"  \
        --slave   /usr/bin/gcc-ranlib gcc-ranlib "/usr/bin/gcc-ranlib-${version}"  \
        --slave   /usr/bin/gcov gcov "/usr/bin/gcov-${version}"  \
        --slave   /usr/bin/gcov-dump gcov-dump "/usr/bin/gcov-dump-${version}"  \
        --slave   /usr/bin/gcov-tool gcov-tool "/usr/bin/gcov-tool-${version}"
  
}

function register_clang_version {
    # https://gist.github.com/junkdog/70231d6953592cd6f27def59fe19e50d
    local version=$1
    local priority=$2
    info "  |  |--> Registering clang version ${version} with priority ${priority} (only version 10 supported! unless uncommented line 61-65)"  
    
    # Basic installation following https://apt.llvm.org/

    # NOTE: uncomment the following line for version different from 10 <--
    # wget https://apt.llvm.org/llvm.sh  # avoid to download for stability
    # chmod 777 llvm.sh
    # ./llvm.sh ${version}
    # rm ./llvm.sh

    # Install clang-tools and friends
    # Cland and co
    apt-get install -yyqq clang-${version} \
      clang-tools-${version} \
      clang-tidy-${version} \
      clang-${version}-doc \
      libclang-common-${version}-dev \
      libclang-${version}-dev \
      libclang1-${version} \
      clang-format-${version} \
      python3-clang-${version} \
      clangd-${version}

    # lldb
    apt-get install -yyqq lldb-${version}
    # lld (linder)
    apt-get install -yyqq lld-${version}
    # libc++
    apt-get install -yyqq libc++-${version}-dev libc++abi-${version}-dev
    # OpenMP
    apt-get install -yyqq libomp-${version}-dev

    update-alternatives \
        --install /usr/bin/llvm-config       llvm-config      "/usr/bin/llvm-config-${version}" "${priority}" \
        --slave   /usr/bin/llvm-ar           llvm-ar          "/usr/bin/llvm-ar-${version}" \
        --slave   /usr/bin/llvm-as           llvm-as          "/usr/bin/llvm-as-${version}" \
        --slave   /usr/bin/llvm-bcanalyzer   llvm-bcanalyzer  "/usr/bin/llvm-bcanalyzer-${version}" \
        --slave   /usr/bin/llvm-cov          llvm-cov         "/usr/bin/llvm-cov-${version}" \
        --slave   /usr/bin/llvm-diff         llvm-diff        "/usr/bin/llvm-diff-${version}" \
        --slave   /usr/bin/llvm-dis          llvm-dis         "/usr/bin/llvm-dis-${version}" \
        --slave   /usr/bin/llvm-dwarfdump    llvm-dwarfdump   "/usr/bin/llvm-dwarfdump-${version}" \
        --slave   /usr/bin/llvm-extract      llvm-extract     "/usr/bin/llvm-extract-${version}" \
        --slave   /usr/bin/llvm-link         llvm-link        "/usr/bin/llvm-link-${version}" \
        --slave   /usr/bin/llvm-mc           llvm-mc          "/usr/bin/llvm-mc-${version}" \
        --slave   /usr/bin/llvm-mcmarkup     llvm-mcmarkup    "/usr/bin/llvm-mcmarkup-${version}" \
        --slave   /usr/bin/llvm-nm           llvm-nm          "/usr/bin/llvm-nm-${version}" \
        --slave   /usr/bin/llvm-objdump      llvm-objdump     "/usr/bin/llvm-objdump-${version}" \
        --slave   /usr/bin/llvm-ranlib       llvm-ranlib      "/usr/bin/llvm-ranlib-${version}" \
        --slave   /usr/bin/llvm-readobj      llvm-readobj     "/usr/bin/llvm-readobj-${version}" \
        --slave   /usr/bin/llvm-rtdyld       llvm-rtdyld      "/usr/bin/llvm-rtdyld-${version}" \
        --slave   /usr/bin/llvm-size         llvm-size        "/usr/bin/llvm-size-${version}" \
        --slave   /usr/bin/llvm-stress       llvm-stress      "/usr/bin/llvm-stress-${version}" \
        --slave   /usr/bin/llvm-symbolizer   llvm-symbolizer  "/usr/bin/llvm-symbolizer-${version}" \
        --slave   /usr/bin/llvm-tblgen       llvm-tblgen      "/usr/bin/llvm-tblgen-${version}"

    update-alternatives \
        --install /usr/bin/clang                 clang                 "/usr/bin/clang-${version}" "${priority}" \
        --slave   /usr/bin/clang++               clang++               "/usr/bin/clang++-${version}"  \
        --slave   /usr/bin/clangd                clangd                "/usr/bin/clangd-${version}"  \
        --slave   /usr/bin/asan_symbolize        asan_symbolize        "/usr/bin/asan_symbolize-${version}" \
        --slave   /usr/bin/c-index-test          c-index-test          "/usr/bin/c-index-test-${version}" \
        --slave   /usr/bin/clang-check           clang-check           "/usr/bin/clang-check-${version}" \
        --slave   /usr/bin/clang-cl              clang-cl              "/usr/bin/clang-cl-${version}" \
        --slave   /usr/bin/clang-cpp             clang-cpp             "/usr/bin/clang-cpp-${version}" \
        --slave   /usr/bin/clang-format          clang-format          "/usr/bin/clang-format-${version}" \
        --slave   /usr/bin/clang-format-diff     clang-format-diff     "/usr/bin/clang-format-diff-${version}" \
        --slave   /usr/bin/clang-import-test     clang-import-test     "/usr/bin/clang-import-test-${version}" \
        --slave   /usr/bin/clang-include-fixer   clang-include-fixer   "/usr/bin/clang-include-fixer-${version}" \
        --slave   /usr/bin/clang-offload-bundler clang-offload-bundler "/usr/bin/clang-offload-bundler-${version}" \
        --slave   /usr/bin/clang-query           clang-query           "/usr/bin/clang-query-${version}" \
        --slave   /usr/bin/clang-rename          clang-rename          "/usr/bin/clang-rename-${version}" \
        --slave   /usr/bin/clang-reorder-fields  clang-reorder-fields  "/usr/bin/clang-reorder-fields-${version}" \
        --slave   /usr/bin/clang-tidy            clang-tidy            "/usr/bin/clang-tidy-${version}" \
        --slave   /usr/bin/lldb                  lldb                  "/usr/bin/lldb-${version}" \
        --slave   /usr/bin/lld                   lld                   "/usr/bin/lld-${version}" \
        --slave   /usr/bin/lldb-server           lldb-server           "/usr/bin/lldb-server-${version}"

}

function remove_gcc_alternatives {
  info "  |--> Removing all gcc current alternatives"
  update-alternatives --remove-all gcc 2> /dev/null
  info "  |  |--> ${GREEN}${BOLD}OK${NO_COLOR}"
}

function gcc_alternatives {
  info "  |--> Registering gcc alternatives"
  # To install gcc toolchain versions 6/7/8.
  info "  |  |--> adding gcc ubuntu repository"
  info "  |  |--> here"
  #add-apt-repository -y ppa:ubuntu-toolchain-r/test 1> /dev/null 2>&1
  #apt update -qq
  
  # register_gcc_version <version> <priority>
  info "  |  |--> here"
  register_gcc_version 9 30
  info "  |  |--> ${GREEN}${BOLD}OK${NO_COLOR}"
}

function remove_clang_alternatives {
  info "  |--> Removing all clang current alternatives"
  update-alternatives --remove-all clang 2> /dev/null
  info "  |--> Removing all llvm current alternatives"
  update-alternatives --remove-all llvm 2> /dev/null
  info "  |  |--> ${GREEN}${BOLD}OK${NO_COLOR}"
}

function clang_alternatives {
  # Remove all existing alternatives
  info "  |--> Registering clang alternatives"

  # register_gcc_version <version> <priority>
  # register_clang_version 11 20 
    register_clang_version 10 10

  info "  |--> ${GREEN}${BOLD}OK${NO_COLOR}"   
}

function remove_cc_alternatives {
  info "  |--> Removing all cc current alternatives"
  update-alternatives --remove-all cc 2> /dev/null
  update-alternatives --remove-all c++ 2> /dev/null  
  info "  |  |--> ${GREEN}${BOLD}OK${NO_COLOR}"
}

function cc_alternatives {
  info "|--> Registering cc alternatives"
  # exit on first error
  set -e
  info "  |  |-> Registering gcc with priority 20"  
  update-alternatives \
        --install /usr/bin/cc   cc   /usr/bin/gcc     20 \
        --slave   /usr/bin/c++ c++ /usr/bin/g++  \
        --slave   /usr/bin/ld ld /usr/bin/x86_64-linux-gnu-ld

  info "  |  |--> Registering clang with priority 30"  
  update-alternatives \
        --install /usr/bin/cc   cc   /usr/bin/clang     30 \
        --slave   /usr/bin/c++ c++ /usr/bin/clang++  \
        --slave   /usr/bin/ld ld /usr/bin/lld
  info "  |  |--> ${GREEN}${BOLD}OK${NO_COLOR}"
}


# Check that we have Root UID (https://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script)
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


info "1/2) Remove alternatives"
remove_gcc_alternatives
remove_clang_alternatives
remove_cc_alternatives

# exit on first error
set -e

info "2/2) Setup alternatives"
apt-get update -qq
# Setup GCC toolchain alternatives
gcc_alternatives

# Setup CLANG toolchain
clang_alternatives

# Setup main alternatives
cc_alternatives

info "-->${GREEN}${BOLD}DONE${NO_COLOR}<--" 
apt-get -qq clean all && \
    rm -r -f /tmp/* && \
    rm -r -f /dockerFiles/* && \
    rm -r -f /var/tmp/* && \
    rm -r -f /var/lib/apt/lists/*

