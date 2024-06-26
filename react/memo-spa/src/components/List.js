export default function List({memoItems, handleClick, handleFormContent}) {
  function setSerialNumber() {
    return memoItems.length === 0 ? 1 : memoItems[memoItems.length - 1].id + 1
  }

  const memoLists = memoItems.map(memo => {
    return(
      <div className='flex' key={memo.id}>
        <p className='text-xl cursor-pointer underline hover:no-underline' onClick={() => {
          handleFormContent({context: memo.body, number: memo.id})
        }}
        >
          {memo.title}
        </p>
      </div>
    )
  })

  return(
    <div className='mt-6 text-xl text-zinc-600 m-auto w-1/2'>
      <div className='flex'>
        <div className='mt-6 w-1/2 h-1/2 m-auto bg-white text-zinc-600 text-sm'>
          {memoLists}
          <button className='text-lg' onClick={() => handleClick(setSerialNumber())}>+</button>
        </div>
      </div>
    </div>
  )
}
