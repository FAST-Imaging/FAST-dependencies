# Build DCMTK

create_package_target(dcmtk 3.6.7)
if(WIN32)
create_package_code(
	"
	file(COPY ${INSTALL_DIR}/include/dcmtk DESTINATION ${POST_INSTALL_DIR}/include/)
	file(COPY ${BUILD_DIR}/src/dcmtk/COPYRIGHT DESTINATION ${POST_INSTALL_DIR}/licenses/dcmtk/)
	file(COPY
		${INSTALL_DIR}/bin/dcmdata.dll
                ${INSTALL_DIR}/bin/dcmimgle.dll
		${INSTALL_DIR}/bin/dcmimage.dll
                ${INSTALL_DIR}/bin/dcmjpeg.dll
                ${INSTALL_DIR}/bin/ijg8.dll
                ${INSTALL_DIR}/bin/ijg12.dll
                ${INSTALL_DIR}/bin/ijg16.dll
                ${INSTALL_DIR}/bin/oflog.dll
                ${INSTALL_DIR}/bin/ofstd.dll
		DESTINATION ${POST_INSTALL_DIR}/bin/
	)
	file(COPY
      ${INSTALL_DIR}/lib/dcmdata.lib
      ${INSTALL_DIR}/lib/dcmimgle.lib
      ${INSTALL_DIR}/lib/dcmimage.lib
      ${INSTALL_DIR}/lib/dcmjpeg.lib
      ${INSTALL_DIR}/lib/oflog.lib
      ${INSTALL_DIR}/lib/ofstd.lib
      DESTINATION ${POST_INSTALL_DIR}/lib/
      )
      "
)
elseif(APPLE)
create_package_code(
	"
	file(COPY ${INSTALL_DIR}/include/dcmtk DESTINATION ${POST_INSTALL_DIR}/include/)
	file(COPY ${BUILD_DIR}/src/dcmtk/COPYRIGHT DESTINATION ${POST_INSTALL_DIR}/licenses/dcmtk/)
	file(COPY ${INSTALL_DIR}/lib/libdcmdata.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libdcmimgle.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libdcmimage.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libdcmjpeg.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libijg8.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libijg12.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libijg16.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/liboflog.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libofstd.dylib DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	"
)

else()
create_package_code(
	"
	file(COPY ${INSTALL_DIR}/include/dcmtk DESTINATION ${POST_INSTALL_DIR}/include/)
	file(COPY ${BUILD_DIR}/src/dcmtk/COPYRIGHT DESTINATION ${POST_INSTALL_DIR}/licenses/dcmtk/)
	file(COPY ${INSTALL_DIR}/lib/libdcmdata.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libdcmimgle.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libdcmimage.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libdcmjpeg.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libijg8.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libijg12.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libijg16.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/liboflog.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	file(COPY ${INSTALL_DIR}/lib/libofstd.so DESTINATION ${POST_INSTALL_DIR}/lib/ FOLLOW_SYMLINK_CHAIN)
	"
)
endif()

set(MODULES ofstd oflog dcmdata dcmimgle dcmimage dcmjpeg)
ExternalProject_Add(dcmtk
        PREFIX ${BUILD_DIR}
        BINARY_DIR ${BUILD_DIR}
        GIT_REPOSITORY "https://github.com/DCMTK/dcmtk.git"
	GIT_TAG "DCMTK-${VERSION}"
        CMAKE_ARGS
            -DCMAKE_MACOSX_RPATH=ON
            -DBUILD_SHARED_LIBS=ON
            -DBUILD_APPS=OFF
            -DDCMTK_ENABLE_BUILTIN_DICTIONARY=ON
            -DDCMTK_WITH_DOXYGEN=OFF
	    -DDCMTK_WITH_TIFF=OFF
	    -DDCMTK_WITH_PNG=ON
	    -DDCMTK_WITH_XML=OFF
	    -DDCMTK_WITH_OPENSSL=OFF
	    -DDCMTK_WITH_SNDFILE=OFF
            -DDCMTK_WITH_ICU=OFF
	    -DDCMTK_WITH_ICONV=OFF
            -DCMAKE_INSTALL_RPATH:STRING=$ORIGIN/../lib
	    -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=${CMAKE_OSX_DEPLOYMENT_TARGET}
        CMAKE_CACHE_ARGS
            -DDCMTK_MODULES:STRING=${MODULES}
            -DCMAKE_BUILD_TYPE:STRING=Release
            -DCMAKE_VERBOSE_MAKEFILE:BOOL=OFF
            -DCMAKE_INSTALL_MESSAGE:BOOL=LAZY
            -DCMAKE_INSTALL_PREFIX:STRING=${INSTALL_DIR}
)
