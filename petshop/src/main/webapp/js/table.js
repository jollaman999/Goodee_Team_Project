window.onload = function() {
    var $t_normal = document.getElementsByClassName('normal')[0],
        tableOffset = $t_normal.offsetTop,
        $t_fixed = $t_normal.cloneNode(true);
    $t_fixed.removeChild($t_fixed.getElementsByTagName('tbody')[0]);
    $t_fixed.className = 'fixed';
    $t_normal.parentNode.insertBefore($t_fixed, $t_normal);
    function resizeFixed() {
        var i,
            $t_fixed_th = $t_fixed.getElementsByTagName('th'),
            $t_normal_th = $t_normal.getElementsByTagName('th');
        tableOffset = $t_normal.offsetTop;
        for (i = 0; i < $t_fixed_th.length; i += 1) {
            $t_fixed_th[i].style.width = ($t_normal_th[i].offsetWidth) + "px";
        }
    }
    function scroll() {
        var offset = window.pageYOffset,
            tableOffsetBottom = $t_normal.getElementsByTagName('tbody')[0].offsetHeight + tableOffset;
        if (offset < tableOffset || offset > tableOffsetBottom) {
            $t_fixed.style.display = 'none';
        } else if (offset >= tableOffset && offset <= tableOffsetBottom && $t_fixed.offsetWidth === 0) {
            $t_fixed.style.display = 'table';
        }
    }
    window.onresize = resizeFixed;
    window.onscroll = scroll;
    resizeFixed();
};