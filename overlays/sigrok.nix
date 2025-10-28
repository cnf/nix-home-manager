final: prev: 
{
  libsigrok = prev.libsigrok.overrideAttrs (prevAttrs: {
    buildInputs = (prevAttrs.buildInputs or []) ++ [prev.nettle];
    patches = (prevAttrs.patches or []) ++ [
    #  ../patches/LABPS3005DN.patch
    ];
  });
}
#https://cdn.velleman.eu/downloads/80/labps3005dn_remote_control_syntax.pdf?_gl=1*1s9zgkl*_gcl_au*MzExMTIwMTMwLjE3NDE5NzM4NzQ.
