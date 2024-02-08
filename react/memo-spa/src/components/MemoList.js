export default function MemoList({memoItems}) {
  const memoLists = memoItems.map(memo => {
    <p>{memo}</p>
  })

  return(
    <>
      <div className='mt-6 text-xl text-zinc-600 m-auto w-1/2 font-semibold'>一覧</div>
      <div className='mt-6 w-1/2 h-1/2 m-auto bg-white text-zinc-600 text-sm'>
        {memoLists}
      </div>
    </>
  )
}
