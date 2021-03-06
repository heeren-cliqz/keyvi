

    def __enter__(self):
        return self

    
    def __exit__(self, type, value, traceback):
        self.Compile()


    def Add(self, key , value ):
        assert isinstance(key, (bytes, unicode)), 'arg in_0 wrong type'
        assert isinstance(value, (bytes, unicode)), 'arg in_1 wrong type'

        if isinstance(key, unicode):
            key = key.encode('UTF-8')
        cdef const_char * input_in_0 = <const_char *> key

        if isinstance(value, unicode):
            value = value.encode('UTF-8')
        cdef const_char * input_in_1 = <const_char *> value

        self.inst.get().Add(input_in_0, input_in_1)

        
    def Compile(self, *args):
        if not args:
            with nogil:
                self.inst.get().Compile()
            return

        cdef void* callback = <void*> args[0]
        with nogil:
            self.inst.get().Compile(callback_wrapper, callback)


    def SetManifest(self, manifest):
        m = json.dumps(manifest)
        self.inst.get().SetManifestFromString(m)
