export default function EditForm({isEditable}) {
  if(isEditable) {
    return (
      <div className='text-sm'>
        <textarea className='border'></textarea>
        <div>
          <button className='border'>Save</button>
        </div>
      </div>
    )
  }
}
