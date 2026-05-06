final: prev: 
let
  p269 = final.fetchpatch {
    url = "https://patch-diff.githubusercontent.com/raw/sigrokproject/libsigrok/pull/269.patch";
    hash = "sha256-UgkGP0mSAaO6GN7venfrrKuW+RSLJHO9/N/nEiiMdN8=";
  };
  pVelleman = final.fetchpatch {
    url = "https://github.com/user-attachments/files/23824054/0001-Add-Velleman-DN-support.patch";
    hash = "sha256-hG6c9CgVCdQoqd3AgqbReN1SmWJr6oLWege/oNyIuZI=";
  };
in
{
  mylibsigrok = prev.libsigrok.overrideAttrs (finalAttrs: prevAttrs: {
    buildInputs = (prevAttrs.buildInputs or []) ++ [prev.nettle];
    patches = (prevAttrs.patches or []) ++ [
      p269
      #pVelleman
    ] ++ [
    ];
    version = "unreleased";

    src = prev.fetchFromGitHub {
      owner = "sigrokproject";
      repo = "libsigrok";
      hash = "sha256-j79Wx5FFFKptcwtIjQ0Cvtzl46lnow6bExpMNzI8KlM=";
      #rev = "libsigrok-${finalAttrs.version}";
      rev = "master";
    };

  });
}
#https://cdn.velleman.eu/downloads/80/labps3005dn_remote_control_syntax.pdf?_gl=1*1s9zgkl*_gcl_au*MzExMTIwMTMwLjE3NDE5NzM4NzQ.
