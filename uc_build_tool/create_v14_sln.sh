PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

function pause_imple() 
{ 
	read -p "$*" 
}

function pause()
{ 
	pause_imple 'Press [Enter] key to continue...' 
} 

function force_recreate_dir()
{
	dir=${1}
	
	if [ -d ${dir} ]
	then
		rm --force --recursive ${dir}
	fi
	
	mkdir --parents ${dir}
}

vs=vs14
platform=${1}
path_build=build_${vs}
path_yasm=${PWD}/yasm-1.3.0-


if [ ${platform} == "x64" ]
then
	target=x86_64-win64-${vs}
	path_build="../${path_build}/x64"
	path_yasm="${path_yasm}win64.exe"
else
	target=x86-win32-${vs}
	path_build="../${path_build}/Win32"
	path_yasm="${path_yasm}win32.exe"
fi

force_recreate_dir ${path_build}

cd ${path_build}

../../configure --target=${target}
make

cp ${path_yasm} "yasm.exe"
