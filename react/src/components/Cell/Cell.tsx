import styles from './Cell.module.css'

type StoneColor = 'black' | 'white' | null

type CellProps = {
  stone: StoneColor
  onClick?: () => void
}

function Cell({ stone, onClick }: CellProps) {
  return (
    <div className={styles.cell} onClick={onClick}>
      {stone && <div className={styles.stone} data-color={stone} />}
    </div>
  )
}

export default Cell
