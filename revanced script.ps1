Clear-Host; $finalcommand = ""; # clear all config on startup
Write-Host "This program will configure your ReVanced features into a single command line.";
Write-Host "This program will ask several questions regarding your setups.";
Write-Host "Type Y or y to say yes, N or n to say no.`n";

$swipec = "-e swipe-controls "; # swipe controls +
$swipec_msg = "Do you want a full control for brightness and volume inside player by just a swipe?";

$sektap = "-e seekbar-tapping "; # seekbar tapping +
$sektap_msg = "Do you want a tap away of seeking by just tapping directly on the seekbar?";

$bgpbck = "-e minimized-playback "; # minimized n bg playback +
$bgpbck_msg = "Are you into turning up the music while the screen is off?";

$amoled = "-e amoled "; # amoled +
$amoled_msg = "Does your phone screen OLED/AMOLED/SuperAMOLED based?";

$ncreat = "-e disable-create-button "; # no create button -
$ncreat_msg = "Do you HATE IT when there is create button when you are not a content creator?";

$ncastb = "-e hide-cast-button "; # no cast button -
$ncastb_msg = "Do you hate it when you accidently tapped the cast button?";

$rytdis = "-e return-youtube-dislike "; # return youtube dislike count +
$rytdis_msg = "Do you want to see the dislike counter back?";

$hautop = "-e hide-autoplay-button "; # hide autoplay button -
$hautop_msg = "Do you hate it when YouTube defaulted Autoplay toggle to on?";

$premiu = "-e premium-heading "; # premium heading +
$premiu_msg = "Do you want to flex on them bois by changing heading to PREMIUM?";

$rvncbr = "-e custom-branding "; # change app icon from youtube to revanced logo +
$rvncbr_msg = "Do you also want to flex them more by changing logo to ReVanced?";

$fscpnl = "-e disable-fullscreen-panels "; # fulscreen comments and description panel -
$fscpnl_msg = "Do you hate the comments and description on the side pane during fullscreen?";

$olqual = "-e old-quality-layout "; # use the old quality selection layout +
$olqual_msg = "Do you like a straightforward option like changing quality on videos?";

$hshort = "-e hide-shorts-button "; # hide shorts button -
$hshort_msg = "Do you hate it when YouTube start added shorts?";

$hwtrmk = "-e hide-watermark "; # hide video watermark at the bottom right video player -
$hwtrmk_msg = "Do you feel that video watermark at the bottom right of player is disturbing?";

$spsrbk = "-e sponsorblock "; # use sponsorblock API -
$spsrbk_msg = "Do you hate sponsor segments?";

$wisech = "-e enable-wide-searchbar "; # wide searchbar +
$wisech_msg = "Do you want a direct access to the search bar on the header?";

$tabply = "-e tablet-mini-player "; # tablet mini player +
$tabply_msg = "Are you on tablet?";

$vidbuf = "-e custom-video-buffer "; # custom vid buffer +
$vidbuf_msg = "DO you want to adjust video buffer of the player?";

$autorp = "-e always-autorepeat "; # Set loop video to true +
$autorp_msg = "Are you into looping into infinity?";

$microg = "-e microg-support "; # implement microg if you are nonroot -
$microg_msg = "Does your phone is non-rooted variants?";

$rvncst = "-e settings "; # revanced settings +
$rvncst_msg = "Do you want to change all the settings above after the fact?";

$debugs = "-e enable-debugging "; # debugging by patching manifest file +
$debugs_msg = "Are you a hacker?";

$speeds = "-e custom-playback-speed "; # enable more playback speed +
$speeds_msg = "Are you a lightspeed listener?";

$authdr = "-e hdr-auto-brightness "; # make hdr video follow system brightness -
$authdr_msg = "Do you hate it when an HDR video flashbanged you?";

$savqua = "-e remember-video-quality "; # save video quality on selection +
$savqua_msg = "Do you want video to remember your video quality selection?";

$midrol = "-e video-ads " # remove video ads -
$midrol_msg = "Do you hate video ads?";

$feedad = "-e general-ads " # remove ads on feed -
$feedad_msg = "Do you hate ads in your feed?";

$infcrd = "-e hide-infocard-suggestions "; # hide infocard -
$infcrd_msg = "DO you find infocards misleading and unreliable?";

$optionsarray = @(
    $swipec,$sektap,$bgpbck,$amoled,$ncreat,$ncastb,
    $rytdis,$hautop,$premiu,$rvncbr,$fscpnl,$olqual,
    $hshort,$hwtrmk,$spsrbk,$wisech,$tabply,$vidbuf,
    $autorp,$microg,$rvncst,$debugs,$speeds,$authdr,
    $savqua,$midrol,$feedad,$infcrd
)
$messagearray = @(
    $swipec_msg,$sektap_msg,$bgpbck_msg,$amoled_msg,$ncreat_msg,$ncastb_msg,
    $rytdis_msg,$hautop_msg,$premiu_msg,$rvncbr_msg,$fscpnl_msg,$olqual_msg,
    $hshort_msg,$hwtrmk_msg,$spsrbk_msg,$wisech_msg,$tabply_msg,$vidbuf_msg,
    $autorp_msg,$microg_msg,$rvncst_msg,$debugs_msg,$speeds_msg,$authdr_msg,
    $savqua_msg,$midrol_msg,$feedad_msg,$infcrd_msg
)
for ($i = 0; $i -lt $optionsarray.Count; $i++) {
    Write-Host $messagearray[$i];
    $addoptions = Read-Host;

    if ($addoptions -eq "N") {
        $finalcommand = $finalcommand + $optionsarray[$i];
    }
    Write-Host "";
}
Write-Host "Your final combined commands is:`n$finalcommand"