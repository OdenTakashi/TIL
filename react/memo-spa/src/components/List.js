import EditForm from './EditForm.js'

export default function MemoList({memoItems, editable, handleClick}) {
  const memoLists = memoItems.map(memo => {
    return(
      <p>{memo}</p>
    )
  })

  return(
    <div className='mt-6 text-xl text-zinc-600 m-auto w-1/2'>
      <p className='font-semibold'>一覧</p>

      <div className='flex'>
        <div className='mt-6 w-1/2 h-1/2 m-auto bg-white text-zinc-600 text-sm'>
          {memoLists}
          <button onClick={handleClick}>+</button>
        </div>
        <EditForm isEditable={editable} handleClick={handleClick}/>
      </div>
    </div>
  )
}
