({
    setButtons: function(cmp) {
        cmp.set("v.disPrev", cmp.get("v.offset") === 0);
        cmp.set("v.disNext", (cmp.get("v.offset") + cmp.get("v.limit"))  >=cmp.get("v.questions").length);
    },
})