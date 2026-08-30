<?php

namespace App\Repository;

use App\Entity\Video;
use App\Model\SearchData;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Knp\Component\Pager\Pagination\PaginationInterface;
use Knp\Component\Pager\PaginatorInterface;

/**
 * @extends ServiceEntityRepository<Video>
 */
class VideoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry, private PaginatorInterface $paginator)
    {
        parent::__construct($registry, Video::class);
    }

    /**
     * Get videos
     * @param int $page
     * @return PaginationInterface
     */

    public function findVideos(int $page, bool $premium): PaginationInterface
    {

        $data = $this->createQueryBuilder("v");

        if (!$premium) {

            $data = $data
                ->where("v.premiumVideo = :premium")
                ->setParameter("premium", false);
        }

        $data = $data
            ->getQuery()
            ->getResult();

        $videos = $this->paginator->paginate($data, $page, 9);

        return $videos;
    }

    public function findbySearch(SearchData $searchData, bool $premium): PaginationInterface
    {
        $qb = $this->createQueryBuilder("v");

        if (!$premium) {
            $qb->andWhere("v.premiumVideo = :premium")
                ->setParameter("premium", false);
        }

        if (!empty($searchData->q)) {
            $qb->andWhere(
                $qb->expr()->orX(
                    $qb->expr()->like("v.title", ":q"),
                    $qb->expr()->like("v.description", ":q")
                )
            )
                ->setParameter("q", "%{$searchData->q}%");
        }

        $data = $qb
            ->getQuery()
            ->getResult();

        $videos = $this->paginator->paginate($data, $searchData->page, 6);

        return $videos;
    }

    //    /**
    //     * @return Video[] Returns an array of Video objects
    //     */
    //    public function findByExampleField($value): array
    //    {
    //        return $this->createQueryBuilder('v')
    //            ->andWhere('v.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->orderBy('v.id', 'ASC')
    //            ->setMaxResults(10)
    //            ->getQuery()
    //            ->getResult()
    //        ;
    //    }

    //    public function findOneBySomeField($value): ?Video
    //    {
    //        return $this->createQueryBuilder('v')
    //            ->andWhere('v.exampleField = :val')
    //            ->setParameter('val', $value)
    //            ->getQuery()
    //            ->getOneOrNullResult()
    //        ;
    //    }
}
