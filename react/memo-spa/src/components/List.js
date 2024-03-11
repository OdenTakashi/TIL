export default function List({updateMemo, memoItems, handleClick, handleFormContent}) {
  function setSerialNumber() {
    return memoItems.length === 0 ? 1 : memoItems[memoItems.length - 1].id + 1
  }

  function deleteMemo(memo) {
    const memos = memoItems.concat()
    const nextMemos = memos.filter(m => {
      return (m.id !== memo.id)
    })
    updateMemo(nextMemos)
    localStorage.setItem('memos', JSON.stringify(nextMemos))
  }

  const memoLists = memoItems.map(memo => {
    return(
      <div className='flex'>
        <p className='cursor-pointer' key={memo.id} onClick={() => {
          handleFormContent({context: memo.body, number: memo.id})
        }}
        >
          {memo.body}
        </p>
        <button className='ml-3' onClick={() => deleteMemo(memo)}>delete</button>
      </div>
    )
  })

  return(
    <div className='mt-6 text-xl text-zinc-600 m-auto w-1/2'>
      <p className='font-semibold'>一覧</p>

      <div className='flex'>
        <div className='mt-6 w-1/2 h-1/2 m-auto bg-white text-zinc-600 text-sm'>
          {memoLists}
          <button onClick={() => handleClick(setSerialNumber())}>+</button>
        </div>
      </div>
    </div>
  )
}
