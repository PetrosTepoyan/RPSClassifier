	??|?5o?@??|?5o?@!??|?5o?@	~??z???~??z???!~??z???"e
=type.googleapis.com/tensorflow.profiler.PerGenericStepDetails$??|?5o?@?z?G???A?G?zm?@Y??S㥛??*	      ?@2h
1Iterator::Model::ForeverRepeat::Prefetch::BatchV27?A`??G@!?Ϻ??X@)????ҝG@1?`?|??X@:Preprocessing2U
Iterator::Model::ForeverRepeat?E???Ը?!u?)?Y7??)sh??|???1?S??n??:Preprocessing2q
:Iterator::Model::ForeverRepeat::Prefetch::BatchV2::Shuffle ?~j?t???!#?u?)???)?~j?t???1#?u?)???:Preprocessing2_
(Iterator::Model::ForeverRepeat::Prefetchy?&1???!T??n0E??)y?&1???1T??n0E??:Preprocessing2F
Iterator::Model??|?5^??!g?`?|???)?~j?t?x?1#?u?)???:Preprocessing:?
]Enqueuing data: you may want to combine small input data chunks into fewer but larger chunks.
?Data preprocessing: you may increase num_parallel_calls in <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#map" target="_blank">Dataset map()</a> or preprocess the data OFFLINE.
?Reading data from files in advance: you may tune parameters in the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch size</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave cycle_length</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer_size</a>)
?Reading data from files on demand: you should read data IN ADVANCE using the following tf.data API (<a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#prefetch" target="_blank">prefetch</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/Dataset#interleave" target="_blank">interleave</a>, <a href="https://www.tensorflow.org/api_docs/python/tf/data/TFRecordDataset#class_tfrecorddataset" target="_blank">reader buffer</a>)
?Other data reading or processing: you may consider using the <a href="https://www.tensorflow.org/programmers_guide/datasets" target="_blank">tf.data API</a> (if you are not using it now)?
:type.googleapis.com/tensorflow.profiler.BottleneckAnalysis?
device?Your program is NOT input-bound because only 0.0% of the total step time sampled is waiting for input. Therefore, you should focus on reducing other time.no*no9~??z???#You may skip the rest of this page.B?
@type.googleapis.com/tensorflow.profiler.GenericStepTimeBreakdown?
	?z?G????z?G???!?z?G???      ??!       "      ??!       *      ??!       2	?G?zm?@?G?zm?@!?G?zm?@:      ??!       B      ??!       J	??S㥛????S㥛??!??S㥛??R      ??!       Z	??S㥛????S㥛??!??S㥛??JCPU_ONLYY~??z???b 